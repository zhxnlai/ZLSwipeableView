//
//  Scheduler.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Action)(void);
typedef BOOL (^EndCondition)(void);

@interface Scheduler : NSObject

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) Action action;
@property (nonatomic, strong) EndCondition endCondition;

- (void)scheduleActionRepeatedly:(Action)action
                        interval:(NSTimeInterval)interval
                    endCondition:(EndCondition)endCondition;

@end
