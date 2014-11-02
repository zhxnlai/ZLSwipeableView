//
//  ZLSwipeableContainerView.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLSwipeableContainterView;

// Delegate
@protocol ZLSwipeableContainerViewDelegate <NSObject>
@optional

- (void)containerView: (ZLSwipeableContainterView *)containerView didSwipeLeft:(UIView *)view;
- (void)containerView: (ZLSwipeableContainterView *)containerView didSwipeRight:(UIView *)view;

@end


// DataSource
@protocol ZLSwipeableContainerViewDataSource <NSObject>
@required
- (UIView *)nextSwipeableViewForContainerView:(ZLSwipeableContainterView *)containerView;
@end

@interface ZLSwipeableContainterView : UIView
@property (nonatomic, weak) id <ZLSwipeableContainerViewDataSource> dataSource;
@property (nonatomic, weak) id <ZLSwipeableContainerViewDelegate> delegate;

/**
 *  Enable this to rotate the views behind the top view. Default to YES.
 */
@property (nonatomic) BOOL isRotationEnabled;
/**
 *  Magnitude of the rotation in degrees
 */
@property (nonatomic) float rotationDegree;
/**
 *  Relative vertical offset of the center of rotation. From 0 to 1. Default to 0.3.
 */
@property (nonatomic) float rotationRelativeYOffsetFromCenter;
/**
 *  Magnitude in points per second.
 */
@property (nonatomic) CGFloat escapeVelocityThreshold;

@property (nonatomic) CGFloat relativeDisplacementThreshold;
/**
 *  Magnitude of velocity at which the swiped view will be animated.
 */
@property (nonatomic) CGFloat pushVelocityMagnitude;
/**
 *  Center of swipable Views. This property is animated.
 */
@property (nonatomic) CGPoint swipeableViewsCenter;
/**
 *  Swiped views will be destroyed when they collide with this Rect
 */
@property (nonatomic) CGRect collisionRect;
/**
 *  Mangintude of rotation for swiping views manually
 */
@property (nonatomic) CGFloat manualSwipeRotationRelativeYOffsetFromCenter;
/**
 *  Discard all swipeable views on the screen.
 */
-(void)discardAllSwipeableViews;
/**
 *  Load up to 3 swipeable views.
 */
-(void)loadNextSwipeableViewsIfNeeded;


-(void)swipeTopViewToLeft;
-(void)swipeTopViewToRight;

@end
