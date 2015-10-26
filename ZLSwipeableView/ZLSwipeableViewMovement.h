//
//  ZLSwipeableViewMovement.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLSwipeableViewMovement : NSObject

@property (nonatomic) CGPoint location;
@property (nonatomic) CGPoint translation;
@property (nonatomic) CGPoint velocity;

- (instancetype)initWithLocation:(CGPoint)location
                      tranlation:(CGPoint)tranlation
                        velocity:(CGPoint)velocity;

@end
