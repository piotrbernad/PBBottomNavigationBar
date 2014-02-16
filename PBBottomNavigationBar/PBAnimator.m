//
//  PBAnimator.m
//  PBBottomNavigationBar
//
//  Created by Piotr Bernad on 16.02.2014.
//  Copyright (c) 2014 Piotr Bernad. All rights reserved.
//

#import "PBAnimator.h"
@implementation PBAnimator

- (void)animationEnded:(BOOL)transitionCompleted {
 // for now nothing to do
}

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

        CGFloat height = 300.0f;

        UIView *snapshotView = [self snapshot];
        UIView *overlayView= [self overlayView:containerRect];

        [[transitionContext containerView] addSubview:snapshotView];
        [[transitionContext containerView] addSubview:overlayView];
        [[transitionContext containerView] addSubview:toView];
        
        [toView setFrame:_bottomBarRect];

        CGRect finalRect = (CGRect){CGRectGetMinX(containerRect),
                                    CGRectGetMaxY(containerRect) - height,
                                    CGRectGetWidth(containerRect),
                                    height};
        
        [self showAnimation:transitionContext toView:toView overlayView:overlayView finalRect:finalRect];

    } else {
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
        [toView setFrame:containerRect];

        [self hideAnimation:transitionContext fromView:fromView toView:toView containerRect:containerRect];

    }
    
}

- (void)hideAnimation:(id <UIViewControllerContextTransitioning>)transitionContext fromView:(UIView *)fromView toView:(UIView *)toView containerRect:(CGRect)containerRect {

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [fromView setFrame:_bottomBarRect];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [fromView removeFromSuperview];
    }];
}

- (void)showAnimation:(id <UIViewControllerContextTransitioning>)transitionContext toView:(UIView *)toView overlayView:(UIView *)overlayView finalRect:(CGRect)finalRect {

    [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.6f animations:^{
        
        [toView setFrame:finalRect];
        [overlayView.layer setOpacity:0.3f];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.5f animations:^{
            
            CGRect middleRect = (CGRect){CGRectGetMinX(finalRect),
                                         CGRectGetMinY(finalRect) + 20.0f,
                                         finalRect.size};
            
            [toView setFrame:middleRect];
            
        } completion:^(BOOL finished) {
           
            [UIView animateWithDuration:[self transitionDuration:transitionContext] * 0.5f animations:^{
               [toView setFrame:finalRect];
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }];
    }];
}

- (UIView *)overlayView:(CGRect)containerRect {
    UIView *overlayView = [[UIView alloc] initWithFrame:containerRect];
    [overlayView setBackgroundColor:[UIColor darkGrayColor]];
    [overlayView.layer setOpacity:0.0f];
    return overlayView;
}


@end
