//
//  DefaultDirectionInterpretor.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "DefaultDirectionInterpretor.h"

@implementation DefaultDirectionInterpretor

- (ZLSwipeableViewSwipeOptions *)interpretDirection:(ZLSwipeableViewDirection)direction
                                               view:(UIView *)view
                                              index:(NSUInteger)index
                                              views:(NSArray<UIView *> *)views
                                      swipeableView:(ZLSwipeableView *)swipeableView {
    CGFloat programaticSwipeVelocity = 1000;
    CGPoint location = CGPointMake(view.center.x, view.center.y * 0.7);
    CGVector directionVector;
    switch (direction) {
    case ZLSwipeableViewDirectionLeft:
        directionVector = CGVectorMake(-programaticSwipeVelocity, 0);
        break;
    case ZLSwipeableViewDirectionRight:
        directionVector = CGVectorMake(programaticSwipeVelocity, 0);
        break;
    case ZLSwipeableViewDirectionUp:
        directionVector = CGVectorMake(0, -programaticSwipeVelocity);
        break;
    case ZLSwipeableViewDirectionDown:
        directionVector = CGVectorMake(0, programaticSwipeVelocity);
        break;
    default:
        directionVector = CGVectorMake(0, 0);
        break;
    }
    return
        [[ZLSwipeableViewSwipeOptions alloc] initWithLocation:location direction:directionVector];
}

@end
