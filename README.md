ZLSwipeableView
===============
[![Build Status](https://travis-ci.org/zhxnlai/ZLSwipeableView.svg?branch=master)](https://travis-ci.org/zhxnlai/ZLSwipeableView)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/zhxnlai/ZLSwipeableView?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A simple view for building card like interface like [Tinder](http://www.gotinder.com/) and [Potluck](https://www.potluck.it/). ZLSwipeableView was originally developed for [Murmur](http://zhxnlai.github.io/#/murmur).

**Notice:** The Objective-C version of ZLSwipeableView is no longer actively maintained. 
### Please checkout the swift version: https://github.com/zhxnlai/ZLSwipeableViewSwift

Preview
---
###Swipe
![swipe](Previews/swipe.gif)
###Swipe Cancel
![cancel](Previews/swipeCancel.gif)
###Swipe Programmatically
![swipeLeft](Previews/swipeLeft.gif)
###Swipe Programmatically II
![swipeLeftRight](Previews/swipeLeftRight.gif)

CocoaPods
---
You can install `ZLSwipeableView` through CocoaPods adding the following to your Podfile:

    pod 'ZLSwipeableView'

Usage
---
Check out the [demo app](https://github.com/zhxnlai/ZLSwipeableView/archive/master.zip) for an example.

`ZLSwipeableView` can be added to storyboard or instantiated programmatically:
~~~objective-c
ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:self.view.frame];
[self.view addSubview:swipeableView];
~~~

A `ZLSwipeableView` **must** have an object that implements `ZLSwipeableViewDataSource` to act as a data source. `ZLSwipeableView` will prefetch **three** views in advance to animate them.
~~~objective-c
// required data source
self.swipeableView.dataSource = self;

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
  return [[UIView alloc] init];
}
~~~
The demo app includes examples of both creating views programmatically and loading views from Xib files that [use Auto Layout](https://github.com/zhxnlai/ZLSwipeableView/issues/9).

A `ZLSwipeableView` can have an optional delegate to receive callback.
~~~objective-c
// optional delegate
self.swipeableView.delegate = self;

#pragma mark - ZLSwipeableViewDelegate
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
  NSLog(@"did cancel swipe");
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y%f", location.x, location.y);
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location  translation:(CGPoint)translation {
	NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y, translation.x, translation.y);
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y%f", location.x, location.y);
}
~~~

To swipe the top view programmatically:
~~~objective-c
[self.swipeableView swipeTopViewToLeft];
[self.swipeableView swipeTopViewToRight];
...
~~~

To discard all views and reload programmatically:
~~~objective-c
[self.swipeableView discardAllSwipeableViews];
[self.swipeableView loadNextSwipeableViewsIfNeeded];
~~~

Requirements
---
- iOS 7 or higher.
- Automatic Reference Counting (ARC).

Credits
---
- Thanks [iamphill](https://github.com/iamphill) for adding new delegates.
- Thanks [mdznr](https://github.com/mdznr) for making the code style consistent.
- Thanks [coryalder](https://github.com/coryalder) for making dataSource and delegate IBOutlets.

License
---
ZLSwipeableView is available under MIT license. See the LICENSE file for more info.
