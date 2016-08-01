//
//  EkoActionSheetViewController.m
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import "EkoActionSheetViewController.h"

@import FXBlurView;

@interface EkoActionSheetViewController (Actions)
- (void)cancelButtonDidTouched:(id)sender;
- (void)applyButtonDidTouched:(id)sender;
@end

static CGFloat const kEkoActionSheetHeaderViewHeight = 50.0f;
static CGFloat const kEkoActionSheetCellHeight = 55.0f;
static CGFloat const kEkoActionSheetTintViewAlpha = 0.5f;
static CGFloat const kEkoActionSheetBlurViewPresentationDuration = 0.34f;
static CGFloat const kEkoActionSheetBlurViewDismissalDuration = 0.24f;
static CGFloat const kEkoActionSheetHeaderCornerRadius = 6.0f;
static CGFloat const kEkoActionSheetButtonAlpha = 0.6f;

@interface EkoActionSheetViewController (UITableView) <UITableViewDelegate, UITableViewDataSource>
@end


@interface EkoActionSheetViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *headerContainerView;
@property (weak, nonatomic) IBOutlet UIView *subHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeightConstraint;
@property (strong, nonatomic) FXBlurView *blurView;

@end

@implementation EkoActionSheetViewController

+ (EkoActionSheetViewController*)instantiateFromStoryBoard
{
    EkoActionSheetViewController *vc = [[UIStoryboard storyboardWithName:@"EkoActionSheet" bundle:[NSBundle bundleForClass:[self class]]] instantiateViewControllerWithIdentifier:NSStringFromClass([EkoActionSheetViewController class])];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return vc;
}

#pragma mark - Getters

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

#pragma mark - setters

- (void)setCancelButtonHidden:(BOOL)cancelButtonHidden
{
    _cancelButtonHidden = cancelButtonHidden;
    _cancelButton.hidden = cancelButtonHidden;
}

- (void)setApplyButtonHidden:(BOOL)applyButtonHidden
{
    _applyButtonHidden = applyButtonHidden;
    _applyButton.hidden = applyButtonHidden;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    UIColor *buttonTitleColor = [self.applyButton titleColorForState:UIControlStateNormal];
    [self.applyButton setTitleColor:[buttonTitleColor colorWithAlphaComponent:kEkoActionSheetButtonAlpha] forState:UIControlStateDisabled];
    
    self.titleLabel.text = self.actionSheetTitle ? self.actionSheetTitle : NSLocalizedString(@"", nil);

    NSString *cancelTitle = self.cancelButtonTitle ? self.cancelButtonTitle : NSLocalizedString(@"Cancel", nil);
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonDidTouched:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.hidden = self.cancelButtonHidden;
    
    NSString *applyTitle = self.applyButtonTitle ? self.applyButtonTitle : NSLocalizedString(@"Apply", nil);
    [self.applyButton setTitle:applyTitle forState:UIControlStateNormal];
    [self.applyButton addTarget:self action:@selector(applyButtonDidTouched:) forControlEvents:UIControlEventTouchUpInside];
    self.applyButton.hidden = self.applyButtonHidden;
}

- (CGFloat)visibleViewHeight
{
    CGFloat headerHeight = kEkoActionSheetHeaderViewHeight;
    CGFloat cellHeight = kEkoActionSheetCellHeight;
    NSUInteger cellCount = self.dataSource.numberOfActions;
    CGFloat paddingBottom = 0;
    if ([self.dataSource respondsToSelector:@selector(actionSheetPaddingBottom)]) {
        paddingBottom = [self.dataSource actionSheetPaddingBottom];
    }
    
    return ceilf(headerHeight + cellHeight * cellCount + paddingBottom);
}

@end

@implementation EkoActionSheetViewController (Actions)

#pragma mark - UITapGesture action

- (IBAction)dismissFilteringInterface:(id)sender {
    [self cancelButtonDidTouched:self.cancelButton];
}

- (void)cancelButtonDidTouched:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTouchedCancelButton)]) {
        [self.delegate didTouchedCancelButton];
    }
}

- (void)applyButtonDidTouched:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTouchedApplyButton)]) {
        [self.delegate didTouchedApplyButton];
    }
}

@end

@implementation EkoActionSheetViewController (UITableView)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.numberOfActions;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource cellForActionForTableView:tableView atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectedActionCell:atIndexPath:)]) {
        UITableViewCell *cell = [self.dataSource cellForActionForTableView:tableView atIndexPath:indexPath];
        [self.delegate didSelectedActionCell:cell atIndexPath:indexPath];
    }
}

@end

