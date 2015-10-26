//
//  ZLSwipeableViewMovement.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "ZLSwipeableViewMovement.h"

@implementation ZLSwipeableViewMovement

- (instancetype)initWithLocation:(CGPoint)location
                      tranlation:(CGPoint)tranlation
                        velocity:(CGPoint)velocity {
    self = [super init];
    if (self) {
        self.location = location;
        self.translation = tranlation;
        self.velocity = velocity;
    }
    return self;
}

@end
