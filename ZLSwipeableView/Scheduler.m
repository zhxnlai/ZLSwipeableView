//
//  Scheduler.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "Scheduler.h"

@implementation Scheduler

- (void)scheduleActionRepeatedly:(Action)action
                        interval:(NSTimeInterval)interval
                    endCondition:(EndCondition)endCondition {
    if (self.timer != nil || interval <= 0) {
        return;
    }

    self.action = action;
    self.endCondition = endCondition;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                  target:self
                                                selector:@selector(doAction)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)doAction {
    if (!self.action || !self.endCondition || self.endCondition()) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    self.action();
}

@end
