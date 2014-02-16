//
//  PBBottomBarNavigationViewController.m
//  PBBottomNavigationBar
//
//  Created by Piotr Bernad on 16.02.2014.
//  Copyright (c) 2014 Piotr Bernad. All rights reserved.
//

#import "PBBottomBarNavigationViewController.h"
#import "PlayerViewController.h"
#import "PBAnimator.h"

@interface PBBottomBarNavigationViewController ()

@property (nonatomic, strong) PBAnimator *animator;

@end

@implementation PBBottomBarNavigationViewController

#pragma mark - to remove

- (UIView *)bottomBar {
    UIView *bottom = [[UIView alloc] init];
    [bottom setBackgroundColor:[UIColor redColor]];
    [bottom setUserInteractionEnabled:YES];

    UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25.0f)];
    [tapLabel setTextAlignment:NSTextAlignmentCenter];
    [tapLabel setBackgroundColor:[UIColor clearColor]];
    [tapLabel setTextColor:[UIColor whiteColor]];
    [tapLabel setText:@"Tap here"];
    [bottom addSubview:tapLabel];
    
    return bottom;
}

#pragma mark - end

- (void)awakeFromNib {
    _bottomBarHeight = 25.0f;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    _animator = [[PBAnimator alloc] init];
    
    [self setBottomBarView:[self bottomBar]];
    
    [self setBottomBarVisible:YES];
    [self setTapGestureRecognizerActive:YES];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PlayerViewController *player = [story instantiateViewControllerWithIdentifier:@"player"];
    [self setControllerToShow:player];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    if (_bottomBarVisible) {
        UIView *layoutContainer = [self.view subviews][0];
        [layoutContainer setFrame:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect) - _bottomBarHeight)];
        
        [_bottomBarView setFrame:CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - _bottomBarHeight, CGRectGetWidth(rect), _bottomBarHeight)];
    }
    [self.view bringSubviewToFront:_bottomBarView];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.bottomBarVisible) {
        [self.view setNeedsDisplay];
    }
    
    if (self.visibleViewController == _controllerToShow) {
        
    }
    
}

- (void)setBottomBarView:(UIView *)bottomBarView {
    if (_bottomBarView) {
        [_bottomBarView removeFromSuperview];
    }
    
    [self.view addSubview:bottomBarView];
    _bottomBarView = bottomBarView;
    [self.view setNeedsDisplay];
}

- (void)setTapGestureRecognizerActive:(BOOL)tapGestureRecognizerActive {
    if (tapGestureRecognizerActive) {
        [self createGestureRecognizer];
    }
    _tapGestureRecognizer = nil;
}

- (void)createGestureRecognizer {
    
    if (!_bottomBarVisible) {
        return;
    }
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [_tapGestureRecognizer setNumberOfTapsRequired:1];
    [_tapGestureRecognizer addTarget:self action:@selector(tapRecognized:)];
    [_bottomBarView addGestureRecognizer:_tapGestureRecognizer];
}

- (void)setPresentBottomController:(BOOL)presentBottomController {
    _presentBottomController = presentBottomController;
    
    if (presentBottomController) {
        [self showBottomViewController];
    } else {
        [self hideBottomViewController];
    }
    
}

- (void)tapRecognized:(UITapGestureRecognizer *)sender {
    [self setPresentBottomController:!_presentBottomController];
}

- (void)hideBottomViewController {
    if (_controllerToShow == self.visibleViewController) {
        [self popViewControllerAnimated:YES];
    }
}

- (void)showBottomViewController {
    if (_controllerToShow) {
        [self pushViewController:_controllerToShow animated:YES];
        _presentBottomController = YES;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush && toVC == _controllerToShow) {
        [self.animator setSnapshot:[self.view snapshotViewAfterScreenUpdates:NO]];
        [self setNavigationBarHidden:YES animated:NO];
        [self.animator setBottomBarRect:_bottomBarView.frame];
        [self.animator setShowingBottomController:YES];
        return self.animator;
    }
    
    if (operation == UINavigationControllerOperationPop && fromVC == _controllerToShow) {
        [self setNavigationBarHidden:NO animated:NO];
        [self.animator setBottomBarRect:_bottomBarView.frame];
        [self.animator setShowingBottomController:NO];
        return self.animator;
    }
    
    return nil;
}

@end
