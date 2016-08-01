//
//  EkoActionSheetViewController.h
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EkoActionSheetDataSource <NSObject>
@required
- (NSInteger)numberOfActions;
- (nonnull UITableViewCell*)cellForActionForTableView:(nonnull UITableView*)tableView atIndexPath:(nonnull NSIndexPath*)indexPath;
@optional
- (CGFloat)actionSheetPaddingBottom;
@end

@protocol EkoActionSheetDelegate <NSObject>
@optional
- (void)didTouchedCancelButton;
- (void)didTouchedApplyButton;
- (void)didSelectedActionCell:(nonnull UITableViewCell*)cell atIndexPath:(nonnull NSIndexPath*)indexPath;
@end

@interface EkoActionSheetViewController : UIViewController
@property (nullable, nonatomic, weak) id <EkoActionSheetDataSource> dataSource;
@property (nullable, nonatomic, weak) id <EkoActionSheetDelegate> delegate;
@property (nullable, nonatomic, strong) UIView *blurBackgroundView;
@property (nullable, nonatomic, strong) UIColor *headerViewBackgroundColor;

@property (nullable, nonatomic, strong) NSString *cancelButtonTitle;
@property (nullable, nonatomic, strong) NSString *actionSheetTitle;
@property (nullable, nonatomic, strong) NSString *applyButtonTitle;

@property (nonatomic, assign) BOOL cancelButtonHidden;
@property (nonatomic, assign) BOOL applyButtonHidden;

+ (nonnull EkoActionSheetViewController*)instantiateFromStoryBoard;

@end
