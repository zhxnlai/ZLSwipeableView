//
//  ZLSwipeableViewSwipeOptions.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/26/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLSwipeableViewSwipeOptions : NSObject

@property (nonatomic) CGPoint location;
@property (nonatomic) CGVector direction;

- (instancetype)initWithLocation:(CGPoint)location direction:(CGVector)direction;

@end
