//
//  ViewController.m
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import "ViewController.h"
@import EkoActionSheetController;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSArray<NSString*> *actions;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.actionLabel.text = @"";
}

- (IBAction)presentActionSheet:(id)sender
{
    __weak typeof(self)weakSelf = self;
    void (^itemActionHandler)(NSString*, UIImage *image) = ^(NSString *title, UIImage *image) {
        NSLog(@"did selected item: %@", title);
        weakSelf.actionLabel.text = title;
        weakSelf.imageView.image = image;
    };
    
    EkoActionSheetItem *item1 = [EkoActionSheetItem itemWithTitle:@"iOS"
                                                         subtitle:@"default"
                                                            image:[UIImage imageNamed:@"icon_apple"]
                                                          handler:^(EkoActionSheetItem * _Nonnull item) {
        itemActionHandler(item.title, item.image);
    }];
    
    EkoActionSheetItem *item2 = [EkoActionSheetItem itemWithTitle:@"watchOS"
                                                         subtitle:@"item without image"
                                                          handler:^(EkoActionSheetItem * _Nonnull item) {
        itemActionHandler(item.title, item.image);
    }];
    
    EkoActionSheetItem *item3 = [EkoActionSheetItem itemWithTitle:@"tvOS"
                                                          handler:^(EkoActionSheetItem * _Nonnull item) {
        itemActionHandler(item.title, item.image);
    }];
    
    EkoActionSheetItem *item4 = [EkoActionSheetItem itemWithTitle:@"macOS"
                                                          handler:^(EkoActionSheetItem * _Nonnull item) {
        itemActionHandler(item.title, item.image);
    }];
    
    EkoActionSheetItem *cancelItem = [EkoActionSheetItem cancelItemWithTitle:@"Cancel"
                                                                     handler:^(EkoActionSheetItem * _Nonnull item) {
                                                                         NSLog(@"did received cancel action");
                                                                     }];
    
    EkoActionSheetItem *applyItem = [EkoActionSheetItem applyItemWithTitle:@"Apply"
                                                                   handler:^(EkoActionSheetItem * _Nonnull item) {
                                                                       NSLog(@"did touch apply button");
                                                                   }];
    
    NSArray<EkoActionSheetItem*> *items = @[item1, item2, item3, item4];
    
    [EkoActionSheetViewController presentOnViewController:self
                                                    items:items
                                    headerBackgroundColor:[UIColor purpleColor]
                                       separatorLineColor:[UIColor purpleColor]
                                                    title:@"Select OS"
                                               cancelItem:cancelItem
                                                applyItem:applyItem];
}

@end
