//
//  CustomCell.m
//  EkoActionSheet Example
//
//  Created by Stan Baranouski on 11/25/16.
//  Copyright © 2016 EkoCommunications. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation CustomCell

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}


@end
