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

@property (nonatomic, nullable, strong, readwrite) NSString *cellNibName;
@property (nonatomic, nullable, strong, readwrite) NSString *cellIdentifier;

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

- (nonnull instancetype)initWithCellNibName:(nonnull NSString*)cellNibName
                             cellIdentifier:(nonnull NSString*)identifier
                                 cellHeight:(nullable EkoActionSheetCustomCellHeightBlock)heightBlock
                              configureCell:(nonnull EkoActionSheetCustomCellConfigureBlock)configureCellBlock
                       didSelectCellHandler:(nullable EkoActionSheetCustomCellDidSelectCellBlock)didSelectCellHandler
{
    self = [super init];
    if (self) {
        _cellNibName = cellNibName;
        _cellIdentifier = identifier;
        _heightBlock = heightBlock;
        _cellConfigureBlock = configureCellBlock;
        _didSelectCellHandler = didSelectCellHandler;
    }
    return self;
}

+ (instancetype)cancelItemWithTitle:(NSString *)title
                            handler:(EkoActionSheetCancelItemHandler)cancelHandler
{
    EkoActionSheetItem *item = [[self alloc] initWithTitle:title
                                                  subtitle:nil
                                                     image:nil
                                                   handler:nil
                                                  itemType:EkoActionSheetItemCancel];
    item.cancelHandler = cancelHandler;
    return item;

}

+ (nonnull instancetype)applyItemWithTitle:(nonnull NSString*)title
                                   handler:(nullable EkoActionSheetApplyItemHandler)applyHandler;
{
    EkoActionSheetItem *item = [[self alloc] initWithTitle:title
                                                  subtitle:nil
                                                     image:nil
                                                   handler:nil
                                                  itemType:EkoActionSheetItemApply];
    item.applyHandler = applyHandler;
    return item;
}



@end

