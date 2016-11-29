//
//  EkoActionSheetViewController.m
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import "EkoActionSheetViewController.h"
#import "EkoActionSheetPresentationTransition.h"
#import "EkoActionSheetDismissalTransition.h"
#import "EkoActionSheetItem.h"
#import "EkoActionSheetCell.h"
@import FXBlurView;


static CGFloat const kEkoActionSheetHeaderViewHeight = 50.0f;
static CGFloat const kEkoActionSheetCellHeight = 55.0f;
static CGFloat const kEkoActionSheetTintViewAlpha = 0.5f;
static CGFloat const kEkoActionSheetBlurViewPresentationDuration = 0.34f;
static CGFloat const kEkoActionSheetBlurViewDismissalDuration = 0.24f;
static CGFloat const kEkoActionSheetHeaderCornerRadius = 6.0f;

@interface EkoActionSheetViewController () <UIViewControllerTransitioningDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *headerContainerView;
@property (weak, nonatomic) IBOutlet UIView *subHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeightConstraint;
@property (strong, nonatomic) FXBlurView *blurView;

@property (nullable, nonatomic, strong) UIView *blurBackgroundView;
@property (nonnull, nonatomic) NSArray<EkoActionSheetItem*> *items;
@property (nonnull, nonatomic) UIColor *headerViewBackgroundColor;
@property (nonnull, nonatomic) UIColor *separatorLineColor;
@property (nonnull, nonatomic) NSString *actionSheetTitle;
@property (nonnull, nonatomic) EkoActionSheetItem *cancelItem;
@property (nonnull, nonatomic) EkoActionSheetItem *applyItem;

@end


@implementation EkoActionSheetViewController

#pragma mark - instanitation

+ (EkoActionSheetViewController*)instantiateFromStoryBoard
{
    EkoActionSheetViewController *vc = [[UIStoryboard storyboardWithName:@"EkoActionSheet" bundle:[NSBundle bundleForClass:[self class]]] instantiateViewControllerWithIdentifier:NSStringFromClass([EkoActionSheetViewController class])];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return vc;
}

#pragma mark - presentations 

+ (void)presentOnViewController:(nonnull UIViewController*)fromViewController
                          items:(nonnull NSArray<EkoActionSheetItem*>*)items
          headerBackgroundColor:(nullable UIColor*)headerBackgroundColor
             separatorLineColor:(nullable UIColor*)separatorLineColor
                          title:(nullable NSString*)title
                     cancelItem:(nullable EkoActionSheetItem*)cancelItem
                      applyItem:(nullable EkoActionSheetItem*)applyItem
{
    EkoActionSheetViewController *vc = [self instantiateFromStoryBoard];
    vc.items = items;
    vc.blurBackgroundView = fromViewController.view;
    vc.headerViewBackgroundColor = headerBackgroundColor;
    vc.separatorLineColor = separatorLineColor;
    vc.actionSheetTitle = title;
    vc.cancelItem = cancelItem;
    vc.applyItem = applyItem;
    [fromViewController presentViewController:vc animated:YES completion:nil];
}

+ (void)presentOnViewController:(nonnull UIViewController*)fromViewController
                          items:(nonnull NSArray<EkoActionSheetItem*>*)items
          headerBackgroundColor:(nullable UIColor*)headerBackgroundColor
             separatorLineColor:(nullable UIColor*)separatorLineColor
                          title:(nullable NSString*)title
                     cancelItem:(nullable EkoActionSheetItem*)cancelItem
{
    [self presentOnViewController:fromViewController items:items headerBackgroundColor:nil separatorLineColor:nil title:title cancelItem:cancelItem applyItem:nil];
}

+ (void)presentOnViewController:(nonnull UIViewController*)fromViewController
                          items:(nonnull NSArray<EkoActionSheetItem*>*)items
                          title:(nullable NSString*)title
                     cancelItem:(nullable EkoActionSheetItem*)cancelItem
                      applyItem:(nullable EkoActionSheetItem*)applyItem
{
    [self presentOnViewController:fromViewController items:items headerBackgroundColor:nil separatorLineColor:nil title:title cancelItem:cancelItem applyItem:applyItem];
}

+ (void)presentOnViewController:(nonnull UIViewController*)fromViewController
                          items:(nonnull NSArray<EkoActionSheetItem*>*)items
                          title:(nullable NSString*)title
                     cancelItem:(nullable EkoActionSheetItem*)cancelItem
{
    [self presentOnViewController:fromViewController items:items headerBackgroundColor:nil separatorLineColor:nil title:title cancelItem:cancelItem applyItem:nil];
}

#pragma mark - lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.blurBackgroundView) {
        self.blurView.blurRadius = 10.0f;
        [self showBlurViewOnView:self.blurBackgroundView animationDuration:kEkoActionSheetBlurViewPresentationDuration];
    }
    
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.transitioningDelegate = nil;
    
    if (self.blurBackgroundView) {
        [self removeBlurViewWithAnimationDuration:kEkoActionSheetBlurViewDismissalDuration];
    }
}

#pragma mark - Configure View

- (void)configureView
{
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.cornerRadius = kEkoActionSheetHeaderCornerRadius;
    
    UIColor *headerColor = self.headerViewBackgroundColor ? self.headerViewBackgroundColor : self.headerContainerView.backgroundColor;
    self.headerContainerView.backgroundColor = headerColor;
    self.subHeaderView.backgroundColor = headerColor;
    
    self.containerViewHeightConstraint.constant = [self visibleViewHeight];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.titleLabel.text = self.actionSheetTitle ? self.actionSheetTitle : NSLocalizedString(@"", nil);
    
    if (self.cancelItem) {
        [self.cancelButton setTitle:self.cancelItem.title forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelItemActionHandler) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.cancelButton.hidden = YES;
    }
    
    if (self.applyItem) {
        [self.applyButton setTitle:self.applyItem.title forState:UIControlStateNormal];
        [self.applyButton addTarget:self action:@selector(applyItemActionHandler) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.applyButton.hidden = YES;
    }
    
    NSString *cellNibName = NSStringFromClass([EkoActionSheetCell class]);
    UINib *cellNib = [UINib nibWithNibName:cellNibName bundle:[NSBundle bundleForClass:[self class]]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:cellNibName];
    
    for (EkoActionSheetItem *item in self.items) {
        if (item.cellNibName && item.cellIdentifier) {
            UINib *customCellNib = [UINib nibWithNibName:item.cellIdentifier bundle:nil];
            [self.tableView registerNib:customCellNib forCellReuseIdentifier:item.cellIdentifier];
        }
    }
}

- (CGFloat)visibleViewHeight
{
    CGFloat headerHeight = kEkoActionSheetHeaderViewHeight;
    CGFloat rowHeight = kEkoActionSheetCellHeight;
    
    CGFloat tableHeight = 0;
    for (EkoActionSheetItem *item in self.items) {
        if (item.heightBlock) {
            tableHeight += item.heightBlock();
        } else {
            tableHeight += rowHeight;
        }
    }
    
    return ceilf(headerHeight + tableHeight);
}

#pragma mark - Blur View

- (FXBlurView *)blurView
{
    if (!_blurView)
    {
        _blurView = [[FXBlurView alloc] initWithFrame:self.view.bounds];
        _blurView.tintColor = [UIColor clearColor];
        _blurView.backgroundColor = [UIColor clearColor];
        _blurView.dynamic = NO;
        _blurView.blurRadius = 0.0f;
        _blurView.blurEnabled = YES;
        [_blurView setBlurEnabled:YES];
        _blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        UIView *tintView = [[UIView alloc] initWithFrame:_blurView.bounds];
        tintView.backgroundColor = [UIColor blackColor];
        tintView.alpha = kEkoActionSheetTintViewAlpha;
        tintView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.blurView addSubview:tintView];
    }
    return _blurView;
}

- (void)showBlurViewOnView:(UIView*)view animationDuration:(CGFloat)animationDuration
{
    self.blurView.alpha = 0.0f;
    [view addSubview:self.blurView];
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.blurView.alpha = 1.0f;
    } completion:nil];
}

- (void)removeBlurViewWithAnimationDuration:(CGFloat)animationDuration
{
    [UIView animateWithDuration:animationDuration animations:^{
        self.blurView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.blurView removeFromSuperview];
    }];
}

#pragma mark - Actions

- (void)cancelItemActionHandler
{
    if (self.cancelItem.cancelHandler) {
        __weak typeof(EkoActionSheetItem) *weakItem = self.cancelItem;
        self.cancelItem.cancelHandler(weakItem);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)applyItemActionHandler
{
    if (self.applyItem.applyHandler) {
        __weak typeof(EkoActionSheetItem) *weakItem = self.applyItem;
        self.applyItem.applyHandler(weakItem);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissFilteringInterface:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table view datasource & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EkoActionSheetItem *item = self.items[indexPath.row];
    if (item.heightBlock) {
        return item.heightBlock();
    } else {
        return kEkoActionSheetCellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EkoActionSheetItem *item = self.items[indexPath.row];
    
    if (item.cellNibName && item.cellIdentifier && item.cellConfigureBlock) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return item.cellConfigureBlock(cell);
    } else {
        NSString *reuseIdentifier = NSStringFromClass([EkoActionSheetCell class]);
        
        EkoActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        cell.actionImage = item.image;
        cell.title = item.title;
        cell.subtitle = item.subtitle;
        if (self.separatorLineColor) {
            cell.separatorLineColor = self.separatorLineColor;
        }
        
        // hide separator line for the last cell
        cell.separatorLineHidden = indexPath.row == self.items.count - 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EkoActionSheetItem *item = self.items[indexPath.row];
    if (item.didSelectCellHandler) {
        item.didSelectCellHandler([tableView cellForRowAtIndexPath:indexPath], item, self);
    } else if (item.handler) {
        __weak typeof(EkoActionSheetItem) *weakItem = item;
        item.handler(weakItem, self);
    }
    
    // http://openradar.appspot.com/19563577
    // http://stackoverflow.com/a/30787046/1994889
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
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

