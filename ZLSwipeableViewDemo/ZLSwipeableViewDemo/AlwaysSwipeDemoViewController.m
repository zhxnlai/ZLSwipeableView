//
//  AlwaysSwipeDemoViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/26/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "AlwaysSwipeDemoViewController.h"

@interface AlwaysSwipeDemoViewController () <ZLSwipeableViewSwipingDeterminator>

@end

@implementation AlwaysSwipeDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.swipeableView.swipingDeterminator = self;
}

- (BOOL)shouldSwipeView:(UIView *)view
               movement:(ZLSwipeableViewMovement *)movement
          swipeableView:(ZLSwipeableView *)swipeableView {
    return YES;
}

@end
