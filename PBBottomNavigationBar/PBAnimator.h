//
//  PBAnimator.h
//  PBBottomNavigationBar
//
//  Created by Piotr Bernad on 16.02.2014.
//  Copyright (c) 2014 Piotr Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign, getter = isShowingBottomController) BOOL showingBottomController;
@property (nonatomic, assign) CGRect bottomBarRect;
@property (nonatomic, strong) UIView *snapshot;
@end
