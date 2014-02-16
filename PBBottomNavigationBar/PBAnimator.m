//
//  PBAnimator.m
//  PBBottomNavigationBar
//
//  Created by Piotr Bernad on 16.02.2014.
//  Copyright (c) 2014 Piotr Bernad. All rights reserved.
//

#import "PBAnimator.h"
@implementation PBAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    __block UIView *fromView = fromViewController.view;
    __block UIView *toView = toViewController.view;
    

    CGRect containerRect = [transitionContext containerView].bounds;
    
    if (self.isShowingBottomController) {

        
        UIView *snapshotView = [self snapshot];
        [[transitionContext containerView] addSubview:snapshotView];

        UIView *overlayView = [[UIView alloc] initWithFrame:containerRect];
        [overlayView setBackgroundColor:[UIColor darkGrayColor]];
        [overlayView.layer setOpacity:0.0f];
        [[transitionContext containerView] addSubview:overlayView];
        
        [[transitionContext containerView] addSubview:toView];
        
        [toView setFrame:_bottomBarRect];
        
        CGFloat height = 300.0f;
        
        CGRect finalRect = CGRectMake(CGRectGetMinX(containerRect), CGRectGetMaxY(containerRect) - height, CGRectGetWidth(containerRect), height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.6f animations:^{
            [toView setFrame:finalRect];
            [overlayView.layer setOpacity:0.3f];
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.5f animations:^{
                CGRect middleRect = CGRectMake(CGRectGetMinX(finalRect), CGRectGetMinY(finalRect) + 20.0f, CGRectGetWidth(finalRect), CGRectGetHeight(finalRect));
                [toView setFrame:middleRect];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.5f animations:^{
                    [toView setFrame:finalRect];
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                }];
            }];
            
            
        }];
        
       
    } else {
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
        [toView setFrame:containerRect];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            [fromView setFrame:_bottomBarRect];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            [fromView removeFromSuperview];
        }];

    }
    
}


@end
