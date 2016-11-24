//
//  EkoActionSheetViewController.h
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EkoActionSheetItem;

@interface EkoActionSheetViewController : UIViewController

+ (void)presentOnViewController:(nonnull UIViewController*)fromViewController
                          items:(nonnull NSArray<EkoActionSheetItem*>*)items
          headerBackgroundColor:(nullable UIColor*)headerBackgroundColor
             separatorLineColor:(nullable UIColor*)separatorLineColor
                          title:(nullable NSString*)title
                     cancelItem:(nullable EkoActionSheetItem*)cancelItem
                      applyItem:(nullable EkoActionSheetItem*)applyItem;

+ (void)presentOnViewController:(nonnull UIViewController*)fromViewController
                          items:(nonnull NSArray<EkoActionSheetItem*>*)items
          headerBackgroundColor:(nullable UIColor*)headerBackgroundColor
             separatorLineColor:(nullable UIColor*)separatorLineColor
                          title:(nullable NSString*)title
                     cancelItem:(nullable EkoActionSheetItem*)cancelItem;

+ (void)presentOnViewController:(nonnull UIViewController*)fromViewController
                          items:(nonnull NSArray<EkoActionSheetItem*>*)items
                          title:(nullable NSString*)title
                     cancelItem:(nullable EkoActionSheetItem*)cancelItem
                      applyItem:(nullable EkoActionSheetItem*)applyItem;

+ (void)presentOnViewController:(nonnull UIViewController*)fromViewController
                          items:(nonnull NSArray<EkoActionSheetItem*>*)items
                          title:(nullable NSString*)title
                     cancelItem:(nullable EkoActionSheetItem*)cancelItem;

@end
