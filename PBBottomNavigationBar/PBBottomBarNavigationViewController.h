//
//  PBBottomBarNavigationViewController.h
//  PBBottomNavigationBar
//
//  Created by Piotr Bernad on 16.02.2014.
//  Copyright (c) 2014 Piotr Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBBottomBarNavigationViewController : UINavigationController <UINavigationControllerDelegate>

@property (nonatomic, assign, getter = isBottomBarVisible) BOOL bottomBarVisible;
// default 25.0f;
@property (nonatomic, assign) CGFloat bottomBarHeight;

@property (nonatomic, strong) UIView *bottomBarView;

@property (nonatomic, strong) UIViewController *controllerToShow;

// disable to prevent showing bottom controller when gesture is recognized
@property (nonatomic, assign, getter = isTapGestureRecognizerActive) BOOL tapGestureRecognizerActive;

// tap gesture recgonizer which handle gesture and show/hide bottom controller
@property (nonatomic, strong, readonly) UITapGestureRecognizer *tapGestureRecognizer;

// set this property to show or hide bottom controller
@property (nonatomic, assign, getter = isPresentingBottomController) BOOL presentBottomController;

- (void)hideBottomController;

@end
