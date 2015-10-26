//
//  DefaultViewAnimator.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "DefaultViewAnimator.h"

@implementation DefaultViewAnimator

- (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

- (CGFloat)radiansToDegrees:(CGFloat)radians {
    return radians * 180 / M_PI;
}

- (void)rotateView:(UIView *)view
         forDegree:(float)degree
          duration:(NSTimeInterval)duration
atOffsetFromCenter:(CGPoint)offset
     swipeableView:(ZLSwipeableView *)swipeableView {
    float rotationRadian = [self degreesToRadians:degree];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                       view.center = [swipeableView convertPoint:swipeableView.center
                                                        fromView:swipeableView.superview];
                       CGAffineTransform transform =
                           CGAffineTransformMakeTranslation(offset.x, offset.y);
                       transform = CGAffineTransformRotate(transform, rotationRadian);
                       transform = CGAffineTransformTranslate(transform, -offset.x, -offset.y);
                       view.transform = transform;
                     }
                     completion:nil];
}

- (void)animateView:(UIView *)view
              index:(NSUInteger)index
              views:(NSArray<UIView *> *)views
      swipeableView:(ZLSwipeableView *)swipeableView {
    CGFloat degree = 1;
    NSTimeInterval duration = 0.4;
    CGPoint offset = CGPointMake(0, CGRectGetHeight(swipeableView.bounds) * 0.3);
    switch (index) {
    case 0:
        [self rotateView:view
                     forDegree:0
                      duration:duration
            atOffsetFromCenter:offset
                 swipeableView:swipeableView];
        break;
    case 1:
        [self rotateView:view
                     forDegree:degree
                      duration:duration
            atOffsetFromCenter:offset
                 swipeableView:swipeableView];
        break;
    case 2:
        [self rotateView:view
                     forDegree:-degree
                      duration:duration
            atOffsetFromCenter:offset
                 swipeableView:swipeableView];
        break;
    case 3:
        [self rotateView:view
                     forDegree:0
                      duration:duration
            atOffsetFromCenter:offset
                 swipeableView:swipeableView];
        break;
    default:
        break;
    }
}
/*
 - (void)animateSwipeableViewsIfNeeded {
 UIView *topSwipeableView = self.topSwipeableView;
 if (!topSwipeableView) {
 return;
 }

 for (UIView *cover in self.containerView.subviews) {
 cover.userInteractionEnabled = NO;
 }
 topSwipeableView.userInteractionEnabled = YES;

 for (UIGestureRecognizer *recognizer in topSwipeableView.gestureRecognizers) {
 if (recognizer.state != UIGestureRecognizerStatePossible) {
 return;
 }
 }

 if (self.isRotationEnabled) {
 // rotation
 NSUInteger numSwipeableViews = self.containerView.subviews.count;
 if (numSwipeableViews >= 1) {
 [self.animator removeBehavior:self.swipeableViewSnapBehavior];
 self.swipeableViewSnapBehavior = [self
 snapBehaviorThatSnapView:self.containerView.subviews[numSwipeableViews - 1]
 toPoint:[self convertPoint:self.center fromView:self.superview]];
 [self.animator addBehavior:self.swipeableViewSnapBehavior];
 }
 CGPoint rotationCenterOffset = {0, CGRectGetHeight(topSwipeableView.frame) *
 self.rotationRelativeYOffsetFromCenter};
 if (numSwipeableViews >= 2) {
 [self rotateView:self.containerView.subviews[numSwipeableViews - 2]
 forDegree:self.rotationDegree
 atOffsetFromCenter:rotationCenterOffset
 animated:YES];
 }
 if (numSwipeableViews >= 3) {
 [self rotateView:self.containerView.subviews[numSwipeableViews - 3]
 forDegree:-self.rotationDegree
 atOffsetFromCenter:rotationCenterOffset
 animated:YES];
 }
 }
 }

 */
@end
