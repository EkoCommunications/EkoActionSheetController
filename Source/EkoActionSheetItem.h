//
//  EkoActionSheetItem.h
//  EkoActionSheetController
//
//  Created by Stan Baranouski on 11/24/16.
//
//

#import <Foundation/Foundation.h>
@import UIKit;
@class EkoActionSheetItem;

typedef NS_ENUM(NSUInteger, EkoActionSheetItemType)
{
    EkoActionSheetItemCancel,
    EkoActionSheetItemApply,
    EkoActionSheetItemRegular
};

typedef void(^EkoActionSheetItemHandler)(EkoActionSheetItem *_Nonnull item, UIViewController *_Nonnull actionSheetViewController);

typedef CGFloat(^EkoActionSheetCustomCellHeightBlock)();
typedef UITableViewCell *_Nonnull (^EkoActionSheetCustomCellConfigureBlock)(UITableViewCell *_Nonnull cell);
typedef void(^EkoActionSheetCustomCellDidSelectCellBlock)(UITableViewCell *_Nonnull cell, EkoActionSheetItem *_Nonnull item, UIViewController *_Nonnull actionSheetViewController);

@interface EkoActionSheetItem : NSObject
@property (nonatomic, nullable, strong, readonly) UIImage *image;
@property (nonatomic, nonnull, strong, readonly) NSString *title;
@property (nonatomic, nullable, strong, readonly) NSString *subtitle;
@property (nonatomic, nullable, copy) EkoActionSheetItemHandler handler;
@property (nonatomic, assign, readonly) EkoActionSheetItemType itemType;

@property (nonatomic, nullable, strong, readonly) NSString *cellNibName;
@property (nonatomic, nullable, strong, readonly) NSString *cellIdentifier;
@property (nonatomic, nullable, copy) EkoActionSheetCustomCellHeightBlock heightBlock;
@property (nonatomic, nullable, copy) EkoActionSheetCustomCellConfigureBlock cellConfigureBlock;
@property (nonatomic, nullable, copy) EkoActionSheetCustomCellDidSelectCellBlock didSelectCellHandler;

+ (nonnull instancetype)itemWithTitle:(nonnull NSString*)title
                              handler:(nullable EkoActionSheetItemHandler)handler;

+ (nonnull instancetype)itemWithTitle:(nonnull NSString*)title
                             subtitle:(nullable NSString*)subtitle
                              handler:(nullable EkoActionSheetItemHandler)handler;

+ (nonnull instancetype)itemWithTitle:(nonnull NSString*)title
                                image:(nullable UIImage*)image
                              handler:(nullable EkoActionSheetItemHandler)handler;

+ (nonnull instancetype)itemWithTitle:(nonnull NSString*)title
                             subtitle:(nullable NSString*)subtitle
                                image:(nullable UIImage*)image
                              handler:(nullable EkoActionSheetItemHandler)handler;

+ (nonnull instancetype)cancelItemWithTitle:(nonnull NSString*)title
                                    handler:(nullable EkoActionSheetItemHandler)handler;

+ (nonnull instancetype)applyItemWithTitle:(nonnull NSString*)title
                                   handler:(nullable EkoActionSheetItemHandler)handler;

- (nonnull instancetype)initWithCellNibName:(nonnull NSString*)cellNibName
                             cellIdentifier:(nonnull NSString*)identifier
                                 cellHeight:(nullable EkoActionSheetCustomCellHeightBlock)heightBlock
                              configureCell:(nonnull EkoActionSheetCustomCellConfigureBlock)configureCellBlock
                       didSelectCellHandler:(nullable EkoActionSheetCustomCellDidSelectCellBlock)didSelectCellHandler;


@end
