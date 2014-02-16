//
//  PBAnimator.h
//  PBBottomNavigationBar
//
//  Created by Piotr Bernad on 16.02.2014.
//  Copyright (c) 2014 Piotr Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBAnimator : NSObject <UIViewControllerAnimatedTransitioning>

// determinates whether controller will be hiding or showing up
@property (nonatomic, assign, getter = isShowingBottomController) BOOL showingBottomController;

// bottom bar rect before open bottom controller
@property (nonatomic, assign) CGRect bottomBarRect;

// snapshot of view that was presented before open bottom controller
@property (nonatomic, strong) UIView *snapshot;

// height of controller view after when is presented
@property (nonatomic, assign) CGFloat controllerHeight;

@end
