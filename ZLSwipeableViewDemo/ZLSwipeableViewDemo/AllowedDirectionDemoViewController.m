//
//  CustomDirectionDemoViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/26/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "AllowedDirectionDemoViewController.h"

@interface AllowedDirectionDemoViewController ()

@property (nonatomic, strong) NSArray<NSNumber *> *directions;
@end

@implementation AllowedDirectionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]
        initWithItems:@[ @" ", @"←", @"↑", @"→", @"↓", @"↔︎", @"↕︎", @"☩" ]];
    [segmentedControl addTarget:self
                         action:@selector(segmentedControlAction:)
               forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 7;
    self.navigationItem.titleView = segmentedControl;

    self.directions = @[
        @(ZLSwipeableViewDirectionNone),
        @(ZLSwipeableViewDirectionLeft),
        @(ZLSwipeableViewDirectionUp),
        @(ZLSwipeableViewDirectionRight),
        @(ZLSwipeableViewDirectionDown),
        @(ZLSwipeableViewDirectionHorizontal),
        @(ZLSwipeableViewDirectionVertical),
        @(ZLSwipeableViewDirectionAll)
    ];
}

- (void)segmentedControlAction:(UISegmentedControl *)control {
    self.swipeableView.allowedDirection =
        self.directions[control.selectedSegmentIndex].unsignedIntegerValue;
}

@end
