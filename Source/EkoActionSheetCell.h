//
//  EkoActionSheetCell.h
//  EkoActionSheetController
//
//  Created by Stan Baranouski on 11/24/16.
//
//

#import <UIKit/UIKit.h>

@interface EkoActionSheetCell : UITableViewCell
@property (nonatomic, strong) UIImage *actionImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) UIColor *separatorLineColor;
@property (nonatomic, assign) BOOL separatorLineHidden;
@end
