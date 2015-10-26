//
//  DefaultViewAnimator.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"

@interface DefaultViewAnimator : NSObject <ZLSwipeableViewAnimator>

// self.isRotationEnabled = YES;
// self.rotationDegree = 1;
// self.rotationRelativeYOffsetFromCenter = 0.3;
// self.programaticSwipeRotationRelativeYOffsetFromCenter = -0.2;

/*
 /// Enable this to rotate the views behind the top view. Default to `YES`.
 @property (nonatomic) BOOL isRotationEnabled;

 /// Magnitude of the rotation in degrees
 @property (nonatomic) float rotationDegree;

 /// Relative vertical offset of the center of rotation. From 0 to 1. Default to
 /// 0.3.
 @property (nonatomic) float rotationRelativeYOffsetFromCenter;

 /// Enable this to allow swiping left and right. Default to
 /// `ZLSwipeableViewDirectionBoth`.
 @property (nonatomic) ZLSwipeableViewDirection direction;

 /// Magnitude in points per second.
 @property (nonatomic) CGFloat escapeVelocityThreshold;

 /// The relative distance from center that will
 @property (nonatomic) CGFloat relativeTranslationThreshold;

 /// Magnitude of velocity at which the swiped view will be animated.
 @property (nonatomic) CGFloat pushVelocityMagnitude;

 /// Swiped views will be destroyed when they collide with this rect.
 @property (nonatomic) CGRect collisionRect;

 /// Relative vertical offset of the center of rotation for swiping views
 /// programatically.
 @property (nonatomic) CGFloat programaticSwipeRotationRelativeYOffsetFromCenter;
 */

@end
