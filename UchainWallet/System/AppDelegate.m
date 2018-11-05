//
//  AppDelegate.m
//  UchainWallet
//
//  Created by 李超 on 2018/10/31.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "AppDelegate.h"
#import "UchainSideViewController.h"
#import "UchainWalletInitViewController.h"
#import "UchainNavigationViewController.h"
#import "UchainWalletViewController.h"
#import "UchainNewsViewController.h"
#import "UchainMineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)sharedApplicationDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self localization];
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initWindowsRootViewController];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    NSMutableArray *arr = [[ApexWalletManager shareManager] getWalletsArr];
//    [arr addObjectsFromArray:[[ETHWalletManager shareManager] getWalletsArr]];
    NSArray *arr = [NSArray arrayWithObject:@"1"];
//    NSArray *arr = [NSArray new];
    
    BOOL isFirstCreatDone = [[NSUserDefaults standardUserDefaults] objectForKey:KisFirstCreateWalletDone];
    if (arr.count == 0 && !isFirstCreatDone) {
        UchainWalletInitViewController *walletVC = [[UchainWalletInitViewController alloc] init];
        walletVC.didFinishCreatSub = [RACSubject subject];
        [walletVC.didFinishCreatSub subscribeNext:^(id  _Nullable x) {
            self.window.rootViewController = _sideViewController;
        }];

        self.window.rootViewController = [[UchainNavigationViewController alloc] initWithRootViewController:walletVC];
    }
    else {
        self.window.rootViewController = _sideViewController;
    }
//
//    [ApexAppConfig configAll];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initWindowsRootViewController
{
    UchainWalletViewController *walletViewController = [[UchainWalletViewController alloc] init];
    UchainNavigationViewController *walletNavigationViewController = [[UchainNavigationViewController alloc] initWithRootViewController:walletViewController];
    
    UchainNewsViewController *newsViewController = [[UchainNewsViewController alloc] init];
    UchainNavigationViewController *newsNavigationViewController = [[UchainNavigationViewController alloc] initWithRootViewController:newsViewController];
    
    UchainMineViewController *mineViewController = [[UchainMineViewController alloc] init];
    UchainNavigationViewController *mineNavigationViewController = [[UchainNavigationViewController alloc] initWithRootViewController:mineViewController];
    
    _mainTabBarController = [[RDVTabBarController alloc] init];
    [_mainTabBarController setViewControllers:@[walletNavigationViewController, newsNavigationViewController, mineNavigationViewController]];
    [self customizeTabBarOutlook];
    
    UchainSideViewController *sideViewController = [[UchainSideViewController alloc] init];
    
    _sideViewController = [[YRSideViewController alloc] initWithNibName:nil bundle:nil];
    _sideViewController.rootViewController = _mainTabBarController;
    _sideViewController.rightViewController = sideViewController;
    
    _sideViewController.rightViewShowWidth = scaleWidth375(150);
    _sideViewController.needSwipeShowMenu = NO;//默认开启的可滑动展示
    //动画效果可以被自己自定义，具体请看api
    [_sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        //使用简单的平移动画
        rootView.frame = CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
    //阴影边框
    _sideViewController.showBoundsShadow = NO;
}

- (void)customizeTabBarOutlook
{
    UIImage *finishedImage = [self imageFromColor:[UIColor whiteColor]];
    
    NSArray *tabBarItemSelectImages = @[@"icon-wallet-selected", @"icon-encurage-selected", @"icon-mine-selected"];
    NSArray *tabBarItemDisSelectImages = @[@"icon-wallet", @"icon-encurage", @"icon-mine"];
    NSArray *titleArray = @[@"", @"", @""];
    
    NSDictionary *selectAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UchainUtil mainThemeColor]};
    NSDictionary *deselectAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1]};
    
    NSArray *tabItemsArray = [[_mainTabBarController tabBar] items];
    
    for (NSInteger i = 0; i < tabItemsArray.count; i++) {
        RDVTabBarItem *barItem = (RDVTabBarItem *)[tabItemsArray objectAtIndex:i];
        [barItem setBackgroundSelectedImage:finishedImage withUnselectedImage: nil];
        [barItem setTitle:[titleArray objectAtIndex:i]];
        [barItem setSelectedTitleAttributes:selectAttribute];
        [barItem setUnselectedTitleAttributes:deselectAttribute];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [tabBarItemSelectImages objectAtIndex:i]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [tabBarItemDisSelectImages objectAtIndex:i]]];
        
        [barItem setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
    }
}


- (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1000, 1000);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)localization {
    [SOLocalization configSupportRegions:@[SOLocalizationEnglish,SOLocalizationSimplifiedChinese] fallbackRegion:SOLocalizationEnglish];

    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:KLanguageSetting];

    if (!language) {
        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString *languageName = [appLanguages objectAtIndex:0];
        if ([languageName containsString:@"zh"]) {
            [SOLocalization sharedLocalization].region = SOLocalizationSimplifiedChinese;
        }
        else {
            [SOLocalization sharedLocalization].region = SOLocalizationEnglish;
        }
    }
    else {
        [SOLocalization sharedLocalization].region = language;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
