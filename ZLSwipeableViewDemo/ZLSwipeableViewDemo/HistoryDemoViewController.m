//
//  HistoryDemoViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/26/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "HistoryDemoViewController.h"

@interface HistoryDemoViewController ()

@property (nonatomic, strong) NSString *rightNavBarButtonItemTitle;
@property (nonatomic, strong) UIBarButtonItem *rightNavBarButtonItem;

@end

@implementation HistoryDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.swipeableView.numberOfHistoryItem = NSUIntegerMax;
    self.swipeableView.allowedDirection = ZLSwipeableViewDirectionAll;

    self.rightNavBarButtonItemTitle = @"Rewind";
    self.rightNavBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:self.rightNavBarButtonItemTitle
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = _rightNavBarButtonItem;
    [self updateRightBarButtonItem];
}

- (void)updateRightBarButtonItem {
    NSUInteger historyLength = self.swipeableView.history.count;
    BOOL enabled = historyLength != 0;
    self.navigationItem.rightBarButtonItem.enabled = enabled;
    if (!enabled) {
        self.navigationItem.rightBarButtonItem.title = self.rightNavBarButtonItemTitle;
        return;
    }
    self.navigationItem.rightBarButtonItem.title =
        [NSString stringWithFormat:@"%@(%lu)", self.rightNavBarButtonItemTitle, historyLength];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    [self updateRightBarButtonItem];
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)barButtonItem {
    [self.swipeableView rewind];
    [self updateRightBarButtonItem];
}

@end
