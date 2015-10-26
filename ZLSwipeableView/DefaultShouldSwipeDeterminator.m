//
//  DefaultShouldSwipeDeterminator.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "DefaultShouldSwipeDeterminator.h"
#import "Utils.h"

@implementation DefaultShouldSwipeDeterminator

- (BOOL)shouldSwipeView:(UIView *)view
               movement:(ZLSwipeableViewMovement *)movement
          swipeableView:(ZLSwipeableView *)swipeableView {
    CGPoint translation = movement.translation;
    CGPoint velocity = movement.velocity;
    CGRect bounds = swipeableView.bounds;
    CGFloat minTranslationInPercent = swipeableView.minTranslationInPercent;
    CGFloat minVelocityInPointPerSecond = swipeableView.minVelocityInPointPerSecond;
    CGFloat allowedDirection = swipeableView.allowedDirection;

    return [self isDirectionAllowed:translation allowedDirection:allowedDirection] &&
           [self isTranslation:translation inTheSameDirectionWithVelocity:velocity] &&
           ([self isTranslationLargeEnough:translation
                   minTranslationInPercent:minTranslationInPercent
                                    bounds:bounds] ||
            [self isVelocityLargeEnough:velocity
                minVelocityInPointPerSecond:minVelocityInPointPerSecond]);
}

- (BOOL)isTranslation:(CGPoint)p1 inTheSameDirectionWithVelocity:(CGPoint)p2 {
    return signNum(p1.x) == signNum(p2.x) && signNum(p1.y) == signNum(p2.y);
}

- (BOOL)isDirectionAllowed:(CGPoint)translation
          allowedDirection:(ZLSwipeableViewDirection)allowedDirection {
    return (ZLSwipeableViewDirectionFromPoint(translation) & allowedDirection) !=
           ZLSwipeableViewDirectionNone;
}

- (BOOL)isTranslationLargeEnough:(CGPoint)translation
         minTranslationInPercent:(CGFloat)minTranslationInPercent
                          bounds:(CGRect)bounds {
    return ABS(translation.x) > minTranslationInPercent * bounds.size.width ||
           ABS(translation.y) > minTranslationInPercent * bounds.size.height;
}

- (BOOL)isVelocityLargeEnough:(CGPoint)velocity
  minVelocityInPointPerSecond:(CGFloat)minVelocityInPointPerSecond {
    return CGPointMagnitude(velocity) > minVelocityInPointPerSecond;
}

int signNum(CGFloat n) { return (n < 0) ? -1 : (n > 0) ? +1 : 0; }

@end
