//
//  ViewController.m
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import "ViewController.h"
@import EkoActionSheetController;

@interface ViewController () <EkoActionSheetDataSource, EkoActionSheetDelegate, UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (nonatomic, strong) NSArray<NSString*> *actions;
@property (nonatomic, strong) EkoActionSheetViewController *actionSheetVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *actions = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        NSString *action = [NSString stringWithFormat:@"Action %d", i+1];
        [actions addObject:action];
    }
    _actions = [actions copy];

    self.actionSheetVC = [EkoActionSheetViewController instantiateFromStoryBoard];
    self.actionSheetVC.dataSource = self;
    self.actionSheetVC.delegate = self;
    self.actionSheetVC.blurBackgroundView = self.view;
//    self.actionSheetVC.cancelButtonHidden = YES;
//    self.actionSheetVC.headerViewBackgroundColor = [UIColor purpleColor];
    self.actionSheetVC.actionSheetTitle = @"Eko Action Sheet";
    self.actionSheetVC.transitioningDelegate = self;
    
    self.actionLabel.text = @"";
}

- (IBAction)showButtonAction:(id)sender {
     [self presentViewController:self.actionSheetVC animated:YES completion:nil];
}

#pragma mark - EkoActionSheet

- (NSInteger)numberOfActions
{
    return self.actions.count;
}

/*
- (CGFloat)actionSheetPaddingBottom
{
    UITabBarController *tabBarController = [UITabBarController new];
    return tabBarController.tabBar.frame.size.height;
}
*/

- (UITableViewCell *)cellForActionForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"reuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    NSString *action = _actions[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", action];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didTouchedCancelButton
{
    [self.actionSheetVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTouchedApplyButton
{
    [self.actionSheetVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectedActionCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *action = _actions[indexPath.row];
    self.actionLabel.text = [NSString stringWithFormat:@"%@", action];
}

#pragma mark - UIViewControllerTransitioningDelegate Methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [[EkoActionSheetPresentationTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[EkoActionSheetDismissalTransition alloc] init];
}

@end
