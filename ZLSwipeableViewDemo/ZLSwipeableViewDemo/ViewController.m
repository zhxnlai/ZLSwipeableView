//
//  ViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ViewController.h"
#import "ZLSwipeableView.h"

@interface ViewController () <ZLSwipeableContainerViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZLSwipeableView *container = [[ZLSwipeableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:container];
    
    container.dataSource = self;
}

- (UIView *)nextSwipeableViewForContainerView:(ZLSwipeableView *)containerView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    view.backgroundColor = [UIColor grayColor];
    return view;
}
@end
