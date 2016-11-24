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

typedef void(^EkoActionSheetItemHandler)();

@interface EkoActionSheetItem : NSObject
@property (nonatomic, nullable, strong, readonly) UIImage *image;
@property (nonatomic, nonnull, strong, readonly) NSString *title;
@property (nonatomic, nullable, strong, readonly) NSString *subtitle;
@property (nonatomic, nullable, copy) EkoActionSheetItemHandler handler;
@property (nonatomic, assign, readonly) EkoActionSheetItemType itemType;

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

@end
