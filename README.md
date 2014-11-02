ZLSwipeableView
===============
A simple view for building card like interface like Tinder and Potluck.

Preview
---
###Swipe
![swipe](Previews/swipe.gif)
###Swipe Cancel
![cancel](Previews/swipeCancel.gif)
###Swipe Programmatically
![swipeLeft](Previews/swipeLeft.gif)

CocoaPods
---
You can install `ZLSwipeableView` through CocoaPods adding the following to your Podfile:

    pod 'ZLSwipeableView'

Usage
---
Check out the demo app for an example.

`ZLSwipeableView` can be added to storyboard or initialized programmatically:
~~~objective-c
ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:self.view.frame];
[self.view addSubview:swipeableView];
~~~

A `ZLSwipeableView` **must** have an object that implements `ZLSwipeableViewDelegate` to act as a data source. `ZLSwipeableView` will prefetch **three** views in advance to animate them.
~~~objective-c
self.swipeableView.dataSource = self;

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
  return [[UIView alloc] init];
}
~~~

To swipe the top view programmatically:
~~~objective-c
[self.swipeableView swipeTopViewToLeft];
[self.swipeableView swipeTopViewToRight];
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

License
---
ZLSwipeableView is available under MIT license. See the LICENSE file for more info.
