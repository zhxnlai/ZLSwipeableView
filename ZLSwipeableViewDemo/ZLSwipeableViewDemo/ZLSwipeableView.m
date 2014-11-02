//
//  ZLSwipeableContainerView.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ZLSwipeableView.h"
#import "ZLPanGestureRecognizer.h"

static const int numPrefetchedViews = 3;
static const float escapeVelocity = 750;

@interface ZLSwipeableView () <UICollisionBehaviorDelegate, UIDynamicAnimatorDelegate>

@property (strong, nonatomic) NSMutableSet *reusableCovers; //MMCoverView

@property (nonatomic) CGPoint coverCenter;


#pragma mark - Animation
@property (strong, nonatomic) UIDynamicAnimator *animator;

@property (nonatomic, strong) UISnapBehavior *coverViewSnapBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *coverViewAttachmentBehavior;

@property (strong, nonatomic) UIAttachmentBehavior *anchorViewAttachmentBehavior;

@property (strong, nonatomic) UIView *anchorContainerView;
@property (strong, nonatomic) UIView *anchorView;
@property (nonatomic) BOOL isAnchorViewVisiable;

@property (nonatomic) CGRect collisionRect;


@property (nonatomic) CGAffineTransform defaultCoverTransform;

@property (strong, nonatomic) UILabel *lastVelocityMagnitudeLabel;
@property (strong, nonatomic) UILabel *currentVelocityThresholdLabel;


@property (strong, nonatomic) NSMutableSet *swipeableViews;

@property (strong, nonatomic) UIView *reuseCoverContainerView;
@property (strong, nonatomic) UIView *coverContainerView;

@end
@implementation ZLSwipeableView

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //TODO: constant declaration
        self.coverCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2-10);
        
        self.isAnchorViewVisiable = NO;
        
        
        self.anchorContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self addSubview:self.anchorContainerView ];
        //        [self sendSubviewToBack:self.anchorContainerView ];
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        self.animator.delegate = self;
        
        
        
        self.coverContainerView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.coverContainerView];
        
        self.reuseCoverContainerView = [[UIView alloc] initWithFrame:self.bounds];
        self.reuseCoverContainerView.userInteractionEnabled = false;
        [self addSubview:self.reuseCoverContainerView];
        [self bringSubviewToFront:self.reuseCoverContainerView];
        
        
    }
    
    return self;
}


#pragma mark - Properties
- (CGRect)collisionRect {
    CGSize viewSize = self.bounds.size;
    CGFloat collisionSizeScale = 6;
    CGSize collisionSize = CGSizeMake(viewSize.width*collisionSizeScale, viewSize.height*collisionSizeScale);
    CGRect collisionRect = CGRectMake(-collisionSize.width/2+viewSize.width/2, -collisionSize.height/2+viewSize.height/2, collisionSize.width, collisionSize.height);
    
    _collisionRect = collisionRect;
    return _collisionRect;
}
- (void)setDataSource:(id<ZLSwipeableContainerViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

- (void)reloadData {
    NSInteger numCover = self.coverContainerView.subviews.count;
    for (NSInteger i=numCover; i<numPrefetchedViews; i++) {
        UIView *coverView = [self nextView];
        [self.coverContainerView addSubview:coverView];
        [self.coverContainerView sendSubviewToBack:coverView];
        coverView.center = self.coverCenter;
    }
//    if (!self.topCoverView.userInteractionEnabled) {
//        [self makeCoverViewRespondToUserInteraction:self.topCoverView];
//    }
    
    if (!((UIView*)self.coverContainerView.subviews.lastObject).userInteractionEnabled) {
        [self makeCoverViewRespondToUserInteraction:self.coverContainerView.subviews.lastObject];
    }

}


- (UIView *)nextView {
    UIView *nextView = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(nextSwipeableViewForContainerView:)]) {
        nextView = [self.dataSource nextSwipeableViewForContainerView:self];
    }
    if (nextView) {
        [nextView addGestureRecognizer:[[ZLPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
    }
    return nextView;
}


#pragma mark - Action
-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self];
    CGPoint location = [recognizer locationInView:self];
    
    UIView *coverView = recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self createAnchorViewForCover:coverView atLocation:location shouldAttachAnchorViewToPoint:YES];
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        //TODO: modify to reduce lag
        self.anchorViewAttachmentBehavior.anchorPoint = location;
        //        self.anchorView.center = location;
    }
    
    if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        
        CGPoint velocity = [recognizer velocityInView:self];
        CGFloat velocityMagnitude = sqrt(pow(velocity.x,2)+pow(velocity.y,2));
        
        //        self.lastVelocityMagnitudeLabel.text = [NSString stringWithFormat:@"v: %f", velocityMagnitude];
        
        CGPoint normalizedVelocity = CGPointMake(velocity.x/velocityMagnitude, velocity.y/velocityMagnitude);
        //        NSLog(@"CurrentV %f", velocityMagnitude);
        //        NSLog(@"normalized velocity x:%f, y:%f", normalizedVelocity.x, normalizedVelocity.y);
        
        //        NSLog(@"translation: %f, %f threshold: %f", translation.x, translation.y, self.bounds.size.width/3);
        
        
        if ((ABS(translation.x)>self.bounds.size.width/4              //displacement
             || velocityMagnitude > escapeVelocity)    //velocity
            && ABS(normalizedVelocity.y)<0.8f) {                    //direction
            //            self.currentObjectIndex++;
            CGFloat scale = velocityMagnitude > escapeVelocity ? 1500:1000;
            CGFloat translationMagnitude = sqrtf(translation.x*translation.x+translation.y*translation.y);
            CGVector direction = CGVectorMake(translation.x/translationMagnitude*scale, translation.y/translationMagnitude*scale);
            
            [self pushAnchorViewForCover:coverView inDirection:direction andCollideInRect:self.collisionRect];
        } else {
            [self.animator removeBehavior:self.coverViewAttachmentBehavior];
            [self.animator removeBehavior:self.anchorViewAttachmentBehavior];
            
            [self.anchorView removeFromSuperview];
            self.coverViewSnapBehavior = [self snapBehaviorThatSnapView:coverView toPoint:self.coverCenter];
            [self.animator addBehavior:self.coverViewSnapBehavior];
        }
        
    }

}

- (void)makeCoverViewRespondToUserInteraction: (UIView *)coverView {
    if (!coverView) {
        return;
    }
    //    NSLog(@"Setting new delegate %@",coverView);
    
    if (self.enableRotation) {
        for (UIView *cover in self.coverContainerView.subviews) {
            cover.userInteractionEnabled = NO;
        }
        
        coverView.userInteractionEnabled = YES;
        

        for (UIGestureRecognizer *recognizer in coverView.gestureRecognizers) {
            if (recognizer.state != UIGestureRecognizerStatePossible) {
                return;
            }
        }
        
        // rotation
        
        
        
        float rotationRadian = [self degreesToRadians: 1];
        CGPoint rotationCenterOffset = {0,CGRectGetHeight(coverView.frame)*0.3};
        NSUInteger numCovers = self.coverContainerView.subviews.count;
        float duration = 0.4;
        if (numCovers>=1) {
            if (!self.coverViewSnapBehavior) {
                self.coverViewSnapBehavior = [self snapBehaviorThatSnapView:self.coverContainerView.subviews[numCovers-1] toPoint:self.coverCenter];
                [self.animator addBehavior:self.coverViewSnapBehavior];
            }
        }
        if (numCovers>=2) {
            UIView *secondCover = self.coverContainerView.subviews[numCovers-2];
            [UIView animateWithDuration:duration animations:^{
                CGAffineTransform transform = CGAffineTransformMakeTranslation(rotationCenterOffset.x, rotationCenterOffset.y);
                transform = CGAffineTransformRotate(transform, rotationRadian);
                transform = CGAffineTransformTranslate(transform,-rotationCenterOffset.x,-rotationCenterOffset.y);
                
                secondCover.transform=transform;
            }];
        }
        //if the third cover is not nil rotate it
        if (numCovers>=3) {
            UIView *thirdCover = self.coverContainerView.subviews[numCovers-3];
            [UIView animateWithDuration:duration animations:^{
                CGAffineTransform transform = CGAffineTransformMakeTranslation(rotationCenterOffset.x, rotationCenterOffset.y);
                transform = CGAffineTransformRotate(transform, -rotationRadian);
                transform = CGAffineTransformTranslate(transform,-rotationCenterOffset.x,-rotationCenterOffset.y);
                
                thirdCover.transform=transform;
            }];
            
        }

    }
    
    
    
}


#pragma mark - Animation

- (UICollisionBehavior *)collisionBehaviorThatBoundsView:(UIView *)view inRect:(CGRect)rect {
    //    NSLog(@"created collision behavior");
    if (!view) {return nil;}
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]
                                              initWithItems:@[view]];
    UIBezierPath *collisionBound = [UIBezierPath bezierPathWithRect:rect];
    [collisionBehavior addBoundaryWithIdentifier:@"c" forPath:collisionBound];
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    return collisionBehavior;
}

- (UIPushBehavior *)pushBehaviorThatPushView:(UIView *)view toDirection:(CGVector)direction {
    //    NSLog(@"created push behavior");
    if (!view) {return nil;}
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc]
                                    initWithItems:@[view]
                                    mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = direction;
    return pushBehavior;
}

- (UISnapBehavior *)snapBehaviorThatSnapView:(UIView *)view toPoint:(CGPoint)point {
    //    NSLog(@"created snap behavior");
    
    if (!view) {return nil;}
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]
                                    initWithItem:view
                                    snapToPoint:point];
    snapBehavior.damping = 0.75f; /* Medium oscillation */
    return snapBehavior;
}

- (UIAttachmentBehavior *)attachmentBehaviorThatAnchorsView:(UIView *) aView toView:(UIView *)anchorView {
    //    NSLog(@"created attachment behavior");
    
    if (!aView) {return nil;}
    
    CGPoint anchorPoint = anchorView.center;
    
    CGPoint p = [self convertPoint:aView.center toView:self];
    UIAttachmentBehavior* attachment = [[UIAttachmentBehavior alloc]
                                        initWithItem:aView
                                        offsetFromCenter:
                                        UIOffsetMake(-(p.x-anchorPoint.x),
                                                     -(p.y-anchorPoint.y))
                                        attachedToItem:anchorView
                                        offsetFromCenter:
                                        UIOffsetMake(0,0)];
    
    
    //    attachment.damping = 100;
    //    attachment.frequency = 1;
    attachment.length = 0;
    
    //        [self.animator addBehavior:self.attachment];
    
    return attachment;
    
}

- (UIAttachmentBehavior *)attachmentBehaviorThatAnchorsView:(UIView *) aView toPoint:(CGPoint )aPoint
{
    if (!aView) {return nil;}
    
    CGPoint p = aView.center;
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc]
                                                initWithItem:aView
                                                offsetFromCenter:
                                                UIOffsetMake(-(p.x-aPoint.x),
                                                             -(p.y-aPoint.y))
                                                attachedToAnchor:aPoint
                                                ];
    
    attachmentBehavior.damping = 100;
    //        self.attachment.frequency = 0.001;
    attachmentBehavior.length = 0;
    
    
    //        [self.animator addBehavior:self.attachmentAnchorItem];
    return attachmentBehavior;
}

- (void)createAnchorViewForCover:(UIView *)coverView atLocation: (CGPoint)location shouldAttachAnchorViewToPoint: (BOOL) shouldAttachToPoint{
    [self.animator removeBehavior:self.coverViewSnapBehavior];
    self.coverViewSnapBehavior = nil;
    
    //    CGPoint location = CGPointMake(coverView.frame.size.width/2, coverView.frame.size.height/2);
    self.anchorView = [[UIView alloc] initWithFrame:
                       CGRectMake(location.x-500, location.y-500, 1000, 1000)];
    [self.anchorView setBackgroundColor:[UIColor blueColor]];
    [self.anchorView setHidden:!self.isAnchorViewVisiable];
    [self.anchorContainerView addSubview: self.anchorView];
    UIAttachmentBehavior *attachToView = [self attachmentBehaviorThatAnchorsView:coverView toView:self.anchorView];
    [self.animator addBehavior:attachToView];
    self.coverViewAttachmentBehavior = attachToView;
    
    
    if (shouldAttachToPoint) {
        UIAttachmentBehavior *attachToPoint = [self attachmentBehaviorThatAnchorsView:self.anchorView toPoint:location];
        [self.animator addBehavior:attachToPoint];
        self.anchorViewAttachmentBehavior = attachToPoint;
    }
    
}
- (void)pushAnchorViewForCover:(UIView *)coverView inDirection:(CGVector)direction andCollideInRect: (CGRect) collisionRect {
    if (direction.dx>0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(containerView:didSwipeRight:)]) {
            [self.delegate swipeableView:self didSwipeRight:coverView];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(containerView:didSwipeLeft:)]) {
            [self.delegate containerView:self didSwipeLeft:coverView];
        }
    }
    NSLog(@"pushing cover to direction: %f, %f", direction.dx, direction.dy);
    [self.animator removeBehavior:self.anchorViewAttachmentBehavior];
    
    UICollisionBehavior *collisionBehavior = [self collisionBehaviorThatBoundsView:self.anchorView inRect:collisionRect];
    collisionBehavior.collisionDelegate = self;
    [self.animator addBehavior:collisionBehavior];
    
    UIPushBehavior *pushBehavior = [self pushBehaviorThatPushView:self.anchorView toDirection:direction];
    [self.animator addBehavior:pushBehavior];
    
    [self.reuseCoverContainerView addSubview:self.anchorView];
    [self.reuseCoverContainerView addSubview:coverView];
    
    self.anchorView = nil;
    
    [self reloadData];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    NSLog(@"ended contact");
    
    NSMutableSet *viewsToRemove = [[NSMutableSet alloc] init];
    
    for (id aBehavior in self.animator.behaviors) {
        if ([aBehavior isKindOfClass:[UIAttachmentBehavior class]]) {
            NSArray *items = ((UIAttachmentBehavior *)aBehavior).items;
            if ([items containsObject:item]) {
                //                NSLog(@"Found the cover that is flying");
                [self.animator removeBehavior:aBehavior];
                [viewsToRemove addObjectsFromArray:items];
                
            }
        }
        if ([aBehavior isKindOfClass:[UIPushBehavior class]]) {
            NSArray *items = ((UIPushBehavior *)aBehavior).items;
            if ([((UIPushBehavior *)aBehavior).items containsObject:item]) {
                if ([items containsObject:item]) {
                    [self.animator removeBehavior:aBehavior];
                    [viewsToRemove addObjectsFromArray:items];
                }
            }
        }
        if ([aBehavior isKindOfClass:[UICollisionBehavior class]]) {
            NSArray *items = ((UICollisionBehavior *)aBehavior).items;
            if ([((UICollisionBehavior *)aBehavior).items containsObject:item]) {
                if ([items containsObject:item]) {
                    [self.animator removeBehavior:aBehavior];
                    [viewsToRemove addObjectsFromArray:items];
                }
            }
        }
    }
    
    for (UIView *view in viewsToRemove) {
        [view removeFromSuperview];
    }
    
    //    [self.animator removeBehavior:behavior];
    
    /*
     [(UIView*)item removeFromSuperview];
     //        NSLog(@"remove from superview");
     for (UIView* v in  self.coversToBeRemovedView.subviews) {
     if ([v isKindOfClass:[MurmurCoverView class]]) {
     if (!CGRectContainsRect(self.view.frame, v.frame)) {
     [v removeFromSuperview];
     //                    NSLog(@"removed view: %@", v);
     }
     }
     
     
     }*/
    
}
#pragma mark - ()

- (CGFloat) degreesToRadians: (CGFloat) degrees
{
    return degrees * M_PI / 180;
};

- (CGFloat) radiansToDegrees: (CGFloat) radians
{
    return radians * 180 / M_PI;
};


@end
