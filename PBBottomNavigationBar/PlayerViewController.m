//
//  PlayerViewController.m
//  PBBottomNavigationBar
//
//  Created by Piotr Bernad on 16.02.2014.
//  Copyright (c) 2014 Piotr Bernad. All rights reserved.
//

#import "PlayerViewController.h"
#import "PBBottomBarNavigationViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (IBAction)close:(id)sender {
    PBBottomBarNavigationViewController *navigation = (PBBottomBarNavigationViewController *)self.navigationController;
    [navigation setPresentBottomController:NO];
}

@end
