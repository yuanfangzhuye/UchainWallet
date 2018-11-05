//
//  UchainUtil.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainUtil.h"

@implementation UchainUtil

+ (UIColor *)tabBarColor
{
    return [UIColor colorWithHexString:@"555555"];
}

+ (UIColor *)tabBarSelectedColor
{
    return [UIColor colorWithHexString:@"1253BF"];
}

+ (UIColor *)mainThemeColor
{
    return [UIColor colorWithHexString:@"1253BF"];
}

+ (UIView *)addLineInView:(UIView *)view color:(UIColor *)color edge:(UIEdgeInsets)edge
{
    NSAssert(view != nil, @"addLineInView: view can not be nil");
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    [view addSubview:line];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"line":line};
    NSString *H;
    NSString *V;
    if (edge.left <0) {
        edge.left = -edge.left;
        H = @"H:[line(left)]-right-|";
        V = @"V:|-top-[line]-bottom-|";
    }else if (edge.right <0){
        edge.right = -edge.right;
        H = @"H:|-left-[line(right)]";
        V = @"V:|-top-[line]-bottom-|";
    }else if (edge.top <0){
        edge.top = -edge.top;
        H = @"H:|-left-[line]-right-|";
        V = @"V:[line(top)]-bottom-|";
    }else if (edge.bottom < 0){
        edge.bottom = -edge.bottom;
        H = @"H:|-left-[line]-right-|";
        V = @"V:|-top-[line(bottom)]";
    }else{
        [line removeFromSuperview];
        return nil;
    }
    NSDictionary *metrics = @{@"left": @(edge.left), @"right": @(edge.right), @"top": @(edge.top), @"bottom": @(edge.bottom)};
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:H options:0 metrics:metrics views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V options:0 metrics:metrics views:views]];
    return line;
}

+ (CGFloat)naviBarHeight{
    static CGFloat height = 0;
    if (height == 0) {
        UINavigationController *naviVC = [UINavigationController new];
        height = CGRectGetHeight(naviVC.navigationBar.bounds) + CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    }
    return height;
}

+ (CGFloat)tabBarHeight{
    static CGFloat tabbarHeight = 0;
    if (tabbarHeight == 0) {
        UITabBarController *tbvc = [UITabBarController new];
        tabbarHeight = tbvc.tabBar.height;
    }
    return tabbarHeight;
}

+ (UchainNavigationViewController *)goWalletTabBarController
{
    YRSideViewController *sideViewController = [[AppDelegate sharedApplicationDelegate] sideViewController];
    [sideViewController hideSideViewController:YES];
    
    RDVTabBarController *mainTabBarController = [[AppDelegate sharedApplicationDelegate] mainTabBarController];
    mainTabBarController.selectedIndex = 0;
    
    UchainNavigationViewController *navigationController = (UchainNavigationViewController *)mainTabBarController.selectedViewController;
    
    return navigationController;
}

+ (void)jumpToMainController:(UIViewController *)currentViewController
{
    NSArray *navControllers = currentViewController.navigationController.viewControllers;
    [currentViewController.navigationController setViewControllers:[navControllers subarrayWithRange:NSMakeRange(0, 1)]];
    
    RDVTabBarController *mainTabBarController = [[AppDelegate sharedApplicationDelegate] mainTabBarController];
    if (mainTabBarController.selectedIndex != 0) {
        [mainTabBarController setSelectedIndex:0];
    }
}

@end
