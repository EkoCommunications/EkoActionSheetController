//
//  ViewController.m
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
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
    void (^itemActionHandler)(NSString*, UIImage *image, UIViewController *vc) = ^(NSString *title, UIImage *image, UIViewController *vc) {
        NSLog(@"did selected item: %@", title);
        weakSelf.actionLabel.text = title;
        weakSelf.imageView.image = image;
        [vc dismissViewControllerAnimated:YES completion:nil];
    };
    
    EkoActionSheetItem *item1 = [EkoActionSheetItem itemWithTitle:@"iOS"
                                                         subtitle:@"default"
                                                            image:[UIImage imageNamed:@"icon_apple"]
                                                          handler:^(EkoActionSheetItem * _Nonnull item, UIViewController * _Nonnull actionSheetViewController)
                                 {
                                     itemActionHandler(item.title, item.image, actionSheetViewController);
                                 }];
    
    EkoActionSheetItem *item2 = [EkoActionSheetItem itemWithTitle:@"watchOS"
                                                         subtitle:@"alignment without image"
                                                          handler:^(EkoActionSheetItem * _Nonnull item, UIViewController * _Nonnull actionSheetViewController)
                                 {
                                     itemActionHandler(item.title, item.image, actionSheetViewController);
                                 }];
    
    EkoActionSheetItem *item3 = [EkoActionSheetItem itemWithTitle:@"tvOS"
                                                          handler:^(EkoActionSheetItem * _Nonnull item, UIViewController * _Nonnull actionSheetViewController)
                                 {
                                     itemActionHandler(item.title, item.image, actionSheetViewController);
                                 }];
    
    EkoActionSheetItem *item4 = [EkoActionSheetItem itemWithTitle:@"macOS"
                                                          handler:^(EkoActionSheetItem * _Nonnull item, UIViewController * _Nonnull actionSheetViewController)
                                 {
                                     itemActionHandler(item.title, item.image, actionSheetViewController);
                                 }];
    
    EkoActionSheetItem *cancelItem = [EkoActionSheetItem cancelItemWithTitle:@"Cancel"
                                                                     handler:^(EkoActionSheetItem * _Nonnull item, UIViewController * _Nonnull actionSheetViewController)
                                      {
                                          [actionSheetViewController dismissViewControllerAnimated:YES completion:nil];
                                          NSLog(@"did received cancel action");
                                      }];
    
    EkoActionSheetItem *customItem = [[EkoActionSheetItem alloc] initWithCellNibName:NSStringFromClass([CustomCell class])
                                                                      cellIdentifier:NSStringFromClass([CustomCell class])
                                                                          cellHeight:^CGFloat{
                                                                              return 80;
                                                                          } configureCell:^UITableViewCell * _Nonnull(UITableViewCell * _Nonnull cell) {
                                                                              CustomCell *myCell = (CustomCell*)cell;
                                                                              [myCell setTitle:@"Custom cells works too!"];
                                                                              return myCell;
                                                                          } didSelectCellHandler:^(UITableViewCell * _Nonnull cell, EkoActionSheetItem * _Nonnull item, UIViewController * _Nonnull actionSheetViewController) {
                                                                              weakSelf.actionLabel.text = @"selected custom cell";
                                                                              weakSelf.imageView.image = nil;
                                                                              [actionSheetViewController dismissViewControllerAnimated:YES completion:nil];
                                                                          }];
    
    EkoActionSheetItem *applyItem = [EkoActionSheetItem applyItemWithTitle:@"Apply"
                                                                   handler:^(EkoActionSheetItem * _Nonnull item, UIViewController * _Nonnull actionSheetViewController)
                                     {
                                         [actionSheetViewController dismissViewControllerAnimated:YES completion:nil];
                                         NSLog(@"did touch apply button");
                                     }];
    
    NSArray<EkoActionSheetItem*> *items = @[item1, item2, item3, item4, customItem];
    
    [EkoActionSheetViewController presentOnViewController:self
                                                    items:items
                                    headerBackgroundColor:[UIColor purpleColor]
                                       separatorLineColor:[UIColor purpleColor]
                                                    title:@"Select OS"
                                               cancelItem:cancelItem
                                                applyItem:applyItem];
}

@end
