//
//  Utils.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"

CGVector CGVectorFromCGPoint(CGPoint point);

CGFloat CGPointMagnitude(CGPoint point);

CGPoint CGPointNormalized(CGPoint point);

CGPoint CGPointMultiply(CGPoint point, CGFloat factor);

ZLSwipeableViewDirection ZLSwipeableViewDirectionFromVector(CGVector directionVector);

ZLSwipeableViewDirection ZLSwipeableViewDirectionFromPoint(CGPoint point);

@interface Utils : NSObject

@end
