//
//  ViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ViewController.h"
#import "ZLSwipeableContainterView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"

@interface ViewController () <ZLSwipeableContainerViewDataSource>
@property (weak, nonatomic) IBOutlet ZLSwipeableContainterView *containerView;

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) NSUInteger colorIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colorIndex = 0;
    self.colors = @[
                    @"Turquoise",
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
                    @"Asbestos",
                    ];

//    ZLSwipeableContainterView *container = [[ZLSwipeableContainterView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:container];
    
    [self.containerView setNeedsLayout];
    [self.containerView layoutIfNeeded];
    self.containerView.dataSource = self;
}
- (IBAction)swipeLeftButtonAction:(UIButton *)sender {
    [self.containerView swipeTopViewToLeft];
}
- (IBAction)swipeRightButtonAction:(UIButton *)sender {
    [self.containerView swipeTopViewToRight];
}
- (IBAction)reloadButtonAction:(UIButton *)sender {
    self.colorIndex = 0;
    [self.containerView discardAllSwipeableViews];
    [self.containerView loadNextSwipeableViewsIfNeeded];
}

- (UIView *)nextSwipeableViewForContainerView:(ZLSwipeableContainterView *)containerView {
    if (self.colorIndex<self.colors.count) {
        CardView *view = [[CardView alloc] initWithFrame:containerView.bounds];
        view.cardColor = [self colorForName:self.colors[self.colorIndex]];
        self.colorIndex++;
        return view;
    }
    return nil;
}
- (UIColor *)colorForName:(NSString *)name
{
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
}

@end
