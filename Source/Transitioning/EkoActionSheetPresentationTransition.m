//
//  EkoActionSheetPresentationTransition.m
//  eko
//
//  Created by Stan Baranouski on 7/4/16.
//  Copyright © 2016 Eko. All rights reserved.
//

#import "EkoActionSheetPresentationTransition.h"
#import "EkoActionSheetConstants.h"

@implementation EkoActionSheetPresentationTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kFormFilteringTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    CGRect fromVCFrame = [transitionContext initialFrameForViewController:fromVC];
    
    CGRect finalFrame = CGRectMake(0, 0, CGRectGetWidth(fromVCFrame), toVC.view.bounds.size.height);
    CGRect initialFrame = CGRectOffset(finalFrame, 0, CGRectGetHeight(containerView.frame));
    
    toVC.view.frame = initialFrame;
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:kFormFilteringPresentationSpringDamping
          initialSpringVelocity:kFormFilteringPresentationSpringVelocity
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.view.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:finished];
                     }];
}

@end
