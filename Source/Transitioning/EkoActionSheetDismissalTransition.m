//
//  EkoActionSheetDismissalTransition.m
//  eko
//
//  Created by Stan Baranouski on 7/4/16.
//  Copyright © 2016 Eko. All rights reserved.
//

#import "EkoActionSheetDismissalTransition.h"
#import "EkoActionSheetConstants.h"

@implementation EkoActionSheetDismissalTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kEkoActionSheetDimsissalTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect frame1 = fromVC.view.frame;
    frame1.origin.y -= kEkoActionSheetDismissalAnimationOneOffsetTop;
    
    [UIView animateWithDuration:kEkoActionSheetDismissalAnimationOneDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         fromVC.view.frame = frame1;
                     } completion:nil];
    
    CGRect frame2 = fromVC.view.frame;
    frame2.origin.y += frame2.size.height + kEkoActionSheetDismissalAnimationOneOffsetTop;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] - kEkoActionSheetDismissalAnimationOneDuration
                          delay:kEkoActionSheetDismissalAnimationOneDuration
         usingSpringWithDamping:kEkoActionSheetDismissalSpringDamping
          initialSpringVelocity:kEkoActionSheetDismissalSpringVelocity
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         fromVC.view.frame = frame2;
                     } completion:^(BOOL finished) {
                         [fromVC.view removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

@end
