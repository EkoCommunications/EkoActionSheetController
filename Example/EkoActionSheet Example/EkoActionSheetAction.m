//
//  EkoActionSheetAction.m
//  EkoActionSheetViewController
//
//  Created by Stan Baranouski on 7/31/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import "EkoActionSheetAction.h"

@interface EkoActionSheetAction ()
@property (nonatomic, assign, readwrite) NSInteger index;
@end

@implementation EkoActionSheetAction

- (nonnull instancetype)initWithIndex:(NSInteger)index action:(EkoActionSheetActionBlock)action
{
    self = [super init];
    if (self)
    {
        _index = index;
        _actionBlock = action;
    }
    return self;
}


@end
