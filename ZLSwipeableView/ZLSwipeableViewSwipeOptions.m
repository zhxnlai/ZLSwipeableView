//
//  ZLSwipeableViewSwipeOptions.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/26/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "ZLSwipeableViewSwipeOptions.h"

@implementation ZLSwipeableViewSwipeOptions

- (instancetype)initWithLocation:(CGPoint)location direction:(CGVector)direction {
    self = [super init];
    if (self) {
        self.location = location;
        self.direction = direction;
    }
    return self;
}

@end
