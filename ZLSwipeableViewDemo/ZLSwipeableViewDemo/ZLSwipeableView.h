//
//  ZLSwipeableContainerView.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLSwipeableView;

// DataSource
@protocol ZLSwipeableContainerViewDelegate <NSObject>
@optional

- (void)containerView: (ZLSwipeableView *)containerView didSwipeLeft:(UIView *)view;
- (void)containerView: (ZLSwipeableView *)containerView didSwipeRight:(UIView *)view;

@end


// DataSource
@protocol ZLSwipeableContainerViewDataSource <NSObject>
@required
- (UIView *)nextSwipeableViewForContainerView:(ZLSwipeableView *)containerView;
@end




@interface ZLSwipeableView : UIView
@property (nonatomic, weak) id <ZLSwipeableContainerViewDataSource> dataSource;
@property (nonatomic, weak) id <ZLSwipeableContainerViewDelegate> delegate;

@property (nonatomic) BOOL enableRotation;


-(void)swipeTopViewToLeft;
@end
