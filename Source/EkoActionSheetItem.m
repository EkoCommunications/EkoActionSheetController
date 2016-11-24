//
//  EkoActionSheetItem.m
//  EkoActionSheetController
//
//  Created by Stan Baranouski on 11/24/16.
//
//

#import "EkoActionSheetItem.h"

@interface EkoActionSheetItem ()
@property (nonatomic, nullable, strong, readwrite) UIImage *image;
@property (nonatomic, nonnull, strong, readwrite) NSString *title;
@property (nonatomic, nullable, strong, readwrite) NSString *subtitle;
@property (nonatomic, assign, readwrite) EkoActionSheetItemType itemType;
@end


@implementation EkoActionSheetItem

- (instancetype)initWithTitle:(nonnull NSString*)title
                     subtitle:(nullable NSString*)subtitle
                        image:(nullable UIImage*)image
                      handler:(nullable EkoActionSheetItemHandler)handler
                     itemType:(EkoActionSheetItemType)itemType
{
    self = [super init];
    if (self) {
        _title = title;
        _subtitle = subtitle;
        _image = image;
        _handler = handler;
        _itemType = itemType;
    }
    return self;
}

+ (instancetype)itemWithTitle:(nonnull NSString*)title
                      handler:(nullable EkoActionSheetItemHandler)handler
{
    return [[self alloc] initWithTitle:title
                              subtitle:nil
                                 image:nil
                               handler:handler
                              itemType:EkoActionSheetItemRegular];
}

+ (instancetype)itemWithTitle:(nonnull NSString*)title
                     subtitle:(nullable NSString*)subtitle
                      handler:(nullable EkoActionSheetItemHandler)handler
{
    return [[self alloc] initWithTitle:title
                              subtitle:subtitle
                                 image:nil
                               handler:handler
                              itemType:EkoActionSheetItemRegular];
}

+ (nonnull instancetype)itemWithTitle:(nonnull NSString*)title
                                image:(nullable UIImage*)image
                              handler:(nullable EkoActionSheetItemHandler)handler
{
    return [[self alloc] initWithTitle:title
                              subtitle:nil
                                 image:image
                               handler:handler
                              itemType:EkoActionSheetItemRegular];
}

+ (instancetype)itemWithTitle:(nonnull NSString*)title
                     subtitle:(nullable NSString*)subtitle
                        image:(nullable UIImage*)image
                      handler:(nullable EkoActionSheetItemHandler)handler
{
    return [[self alloc] initWithTitle:title
                              subtitle:subtitle
                                 image:image
                               handler:handler
                              itemType:EkoActionSheetItemRegular];
}

+ (instancetype)cancelItemWithTitle:(nonnull NSString*)title
                            handler:(nullable EkoActionSheetItemHandler)handler
{
    return [[self alloc] initWithTitle:title
                              subtitle:nil
                                 image:nil
                               handler:handler
                              itemType:EkoActionSheetItemCancel];
}

+ (instancetype)applyItemWithTitle:(nonnull NSString*)title
                           handler:(nullable EkoActionSheetItemHandler)handler
{
    return [[self alloc] initWithTitle:title
                              subtitle:nil
                                 image:nil
                               handler:handler
                              itemType:EkoActionSheetItemApply];
}



@end

