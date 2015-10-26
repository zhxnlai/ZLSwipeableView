//
//  MenuTableViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/26/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "MenuTableViewController.h"
#import "ZLSwipeableViewController.h"
#import "CustomAnimationDemoViewController.h"
#import "AllowedDirectionDemoViewController.h"
#import "HistoryDemoViewController.h"
#import "PreviousViewDemoViewController.h"
#import "AlwaysSwipeDemoViewController.h"

@interface MenuTableViewController ()

@property (nonatomic, strong) NSArray *demoViewControllers;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"ZLSwipeableView";
    self.demoViewControllers = @[
        @"Default",
        @"Custom Animation",
        @"Allowed Direction",
        @"History",
        @"Previous View",
        @"Always Swipe"
    ];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoViewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier =
        [NSString stringWithFormat:@"s%li-r%li", indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self titleForCellAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *title = [self titleForCellAtIndexPath:indexPath];
    ZLSwipeableViewController *vc = [self demoViewControllerForTitle:title];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath {
    return _demoViewControllers[indexPath.row];
}

- (ZLSwipeableViewController *)demoViewControllerForTitle:(NSString *)title {
    if ([title isEqual:@"Default"]) {
        return [[ZLSwipeableViewController alloc] init];
    } else if ([title isEqual:@"Custom Animation"]) {
        return [[CustomAnimationDemoViewController alloc] init];
    } else if ([title isEqual:@"Allowed Direction"]) {
        return [[AllowedDirectionDemoViewController alloc] init];
    } else if ([title isEqual:@"History"]) {
        return [[HistoryDemoViewController alloc] init];
    } else if ([title isEqual:@"Previous View"]) {
        return [[PreviousViewDemoViewController alloc] init];
    } else if ([title isEqual:@"Always Swipe"]) {
        return [[AlwaysSwipeDemoViewController alloc] init];
    }
    return [[ZLSwipeableViewController alloc] init];
}

@end
