//
//  EkoActionSheetAction.h
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EkoActionSheetActionBlock)(NSInteger index);
@interface EkoActionSheetAction : NSObject
@property (nonatomic, assign, readonly) NSInteger index;
@property (nullable, nonatomic, copy) EkoActionSheetActionBlock actionBlock;

- (nonnull instancetype)initWithIndex:(NSInteger)index action:(nullable EkoActionSheetActionBlock)action;

@end
