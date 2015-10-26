//
//  PreviousViewDemoViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/26/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "PreviousViewDemoViewController.h"

@interface PreviousViewDemoViewController ()

@property (nonatomic, strong) NSString *rightNavBarButtonItemTitle;
@property (nonatomic, strong) UIBarButtonItem *rightNavBarButtonItem;

@end

@implementation PreviousViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.swipeableView.numberOfHistoryItem = NSUIntegerMax;
    self.swipeableView.allowedDirection = ZLSwipeableViewDirectionAll;

    self.rightNavBarButtonItemTitle = @"Load Previous";
    self.rightNavBarButtonItem =
        [[UIBarButtonItem alloc] initWithTitle:self.rightNavBarButtonItemTitle
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = _rightNavBarButtonItem;
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)barButtonItem {
    [self.swipeableView rewind];
}

- (UIView *)previousViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    UIView *view = [self nextViewForSwipeableView:swipeableView];
    [self applyRandomTransform:view];
    return view;
}

- (void)applyRandomTransform:(UIView *)view {
    CGFloat width = self.swipeableView.bounds.size.width;
    CGFloat height = self.swipeableView.bounds.size.height;
    CGFloat distance = MAX(width, height);

    CGAffineTransform transform = CGAffineTransformMakeRotation([self randomRadian]);
    transform = CGAffineTransformTranslate(transform, distance, 0);
    transform = CGAffineTransformRotate(transform, [self randomRadian]);
    view.transform = transform;
}

- (CGFloat)randomRadian {
    return (random() % 360) * (M_PI / 180.0);
}

@end
