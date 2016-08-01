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
    return kFormFilteringTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGPoint finalCenter = CGPointMake(0.0f, (fromVC.view.bounds.size.height / 2) + kFormFilteringDismissalViewOffset);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:kFormFilteringDismissalSpringDamping
          initialSpringVelocity:kFormFilteringDismissalSpringVelocity
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         fromVC.view.center = finalCenter;
                     } completion:^(BOOL finished) {
                         [fromVC.view removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

@end
