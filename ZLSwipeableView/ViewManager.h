//
//  ZLViewManager.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ViewManagerState) {
    ViewManagerStateSnapping = 0,
    ViewManagerStateMoving = (1 << 0),
    ViewManagerStateSwiping = (1 << 1),
};

@class ZLSwipeableView;

@interface ViewManager : NSObject

@property (nonatomic, readonly) ViewManagerState state;

@property (nonatomic) CGPoint point;

@property (nonatomic) CGVector direction;

- (instancetype)initWithView:(UIView *)view
               containerView:(UIView *)containerView
                       index:(NSUInteger)index
           miscContainerView:(UIView *)miscContainerView
                    animator:(UIDynamicAnimator *)animator
               swipeableView:(ZLSwipeableView *)swipeableView;

- (void)setStateSnapping:(CGPoint)point;

- (void)setStateMoving:(CGPoint)point;

- (void)setStateSwiping:(CGPoint)point direction:(CGVector)directionVector;

- (void)setStateSnappingDefault;

- (void)setStateSnappingAtContainerViewCenter;

@end
