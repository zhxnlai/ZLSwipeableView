//
//  ZLSwipeableView.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZLSwipeableViewDirection) {
    ZLSwipeableViewDirectionNone = 0,
    ZLSwipeableViewDirectionLeft = (1 << 0),
    ZLSwipeableViewDirectionRight = (1 << 1),
    ZLSwipeableViewDirectionHorizontal = ZLSwipeableViewDirectionLeft |
                                         ZLSwipeableViewDirectionRight,
    ZLSwipeableViewDirectionUp = (1 << 2),
    ZLSwipeableViewDirectionDown = (1 << 3),
    ZLSwipeableViewDirectionVertical = ZLSwipeableViewDirectionUp |
                                       ZLSwipeableViewDirectionDown,
    ZLSwipeableViewDirectionAll = ZLSwipeableViewDirectionHorizontal |
                                  ZLSwipeableViewDirectionVertical,
};

@class ZLSwipeableView;

/// Delegate
@protocol ZLSwipeableViewDelegate <NSObject>
@optional

- (BOOL)swipeableView:(ZLSwipeableView *)swipeableView
     shouldBeginSwipe:(UIView *)view;

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction;

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view;

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didStartSwipingView:(UIView *)view
             atLocation:(CGPoint)location;

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation;

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location;

@end

// DataSource
@protocol ZLSwipeableViewDataSource <NSObject>

@required
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;

@end

@interface ZLSwipeableView : UIView

@property (nonatomic, weak) IBOutlet id<ZLSwipeableViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<ZLSwipeableViewDelegate> delegate;

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
@property (nonatomic) CGFloat relativeDisplacementThreshold;

/// Magnitude of velocity at which the swiped view will be animated.
@property (nonatomic) CGFloat pushVelocityMagnitude;

/// Center of swipable Views. This property is animated.
@property (nonatomic) CGPoint swipeableViewsCenter;

/// Center of swipable Views. This property is animated.
@property (nonatomic) CGPoint swipeableViewsCenterInitial;

/// Swiped views will be destroyed when they collide with this rect.
@property (nonatomic) CGRect collisionRect;

/// Relative vertical offset of the center of rotation for swiping views
/// programatically.
@property (nonatomic) CGFloat programaticSwipeRotationRelativeYOffsetFromCenter;

/// The currently displayed top most view.
@property (nonatomic, readonly) UIView *topSwipeableView;

/// Discard all swipeable views on the screen.
- (void)discardAllSwipeableViews;

/// Load up to 3 swipeable views.
- (void)loadNextSwipeableViewsIfNeeded;

/// Swipe top view to the left programmatically
- (void)swipeTopViewToLeft;

/// Swipe top view to the right programmatically
- (void)swipeTopViewToRight;

/// Swipe top view to the up programmatically
- (void)swipeTopViewToUp;

/// Swipe top view to the down programmatically
- (void)swipeTopViewToDown;

@end
