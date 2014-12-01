//
//  ViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ViewController.h"
#import "ZLSwipeableView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"

@interface ViewController () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (nonatomic, weak) IBOutlet ZLSwipeableView *swipeableView;

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) NSUInteger colorIndex;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colorIndex = 0;
    self.colors = @[@"Turquoise",
                    @"Green Sea",
                    @"Emerald",
                    @"Nephritis",
                    @"Peter River",
                    @"Belize Hole",
                    @"Amethyst",
                    @"Wisteria",
                    @"Wet Asphalt",
                    @"Midnight Blue",
                    @"Sun Flower",
                    @"Orange",
                    @"Carrot",
                    @"Pumpkin",
                    @"Alizarin",
                    @"Pomegranate",
                    @"Clouds",
                    @"Silver",
                    @"Concrete",
                    @"Asbestos"];
    
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
}

- (IBAction)swipeLeftButtonAction:(UIButton *)sender {
    [self.swipeableView swipeTopViewToLeft];
}

- (IBAction)swipeRightButtonAction:(UIButton *)sender {
    [self.swipeableView swipeTopViewToRight];
}

- (IBAction)reloadButtonAction:(UIButton *)sender {
    self.colorIndex = 0;
    [self.swipeableView discardAllSwipeableViews];
    [self.swipeableView loadNextSwipeableViewsIfNeeded];
}


#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view {
	NSLog(@"did swipe left");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view {
	NSLog(@"did swipe right");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
	NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location  translation:(CGPoint)translation {
	NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y, translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
	NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}


#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    if (self.colorIndex < self.colors.count) {
        CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        view.backgroundColor = [self colorForName:self.colors[self.colorIndex]];
        self.colorIndex++;
        return view;
    }
    return nil;
}


#pragma mark - ()

- (UIColor *)colorForName:(NSString *)name
{
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
}

@end
