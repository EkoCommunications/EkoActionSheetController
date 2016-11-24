//
//  EkoActionSheetCell.m
//  EkoActionSheetController
//
//  Created by Stan Baranouski on 11/24/16.
//
//

#import "EkoActionSheetCell.h"

static CGFloat const kTitleLeadingRegularConstant = 50.0f;
static CGFloat const kTitleLeadingNoImageConstant = 15.0f;
static CGFloat const kTitleLabelCenterYPadding = 8.0f;

@interface EkoActionSheetCell ()
@property (nonatomic, strong) NSNumber *separatorLineHeight;

@property (weak, nonatomic) IBOutlet UIImageView *actionImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLableLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelCenterYConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subtitleLableLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subtitleLabelCenterYConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorLineHeightConstraint;

@end

@implementation EkoActionSheetCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.separatorLineHeight = @0.5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.separatorLineHeight) {
        self.separatorLineHeightConstraint.constant = self.separatorLineHeight.floatValue;
    }
    
    if (self.separatorLineColor) {
        self.separatorLineView.backgroundColor = self.separatorLineColor;
    }
    
    self.titleLableLeadingConstraint.constant = self.actionImage == nil ? kTitleLeadingNoImageConstant : kTitleLeadingRegularConstant;
    
    self.titleLabelCenterYConstraint.constant = self.subtitle.length == 0 ? 0 : -kTitleLabelCenterYPadding;
    
    self.subtitleLableLeadingConstraint.constant = self.actionImage == nil ? kTitleLeadingNoImageConstant : kTitleLeadingRegularConstant;
    
    self.subtitleLabel.hidden = self.subtitle.length == 0;
    
    self.separatorLineView.hidden = self.separatorLineHidden;
}

- (void)setActionImage:(UIImage *)actionImage
{
    _actionImage = actionImage;
    self.actionImageView.image = [self.actionImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.actionImageView.tintColor = self.subtitleLabel.textColor;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    self.subtitleLabel.text = subtitle;
}

@end
