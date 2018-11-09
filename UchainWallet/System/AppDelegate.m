//
//  AppDelegate.m
//  UchainWallet
//
//  Created by 李超 on 2018/10/31.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "AppDelegate.h"
#import "ApexAppConfig.h"
#import "AppDelegate+UchainUI.h"
#import "UchainWalletInitViewController.h"
#import "UchainWelcomePageViewController.h"

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
//    NSArray *arr = [NSArray arrayWithObject:@"1"];
    
//    BOOL firstOpenApp = [self isOpenInNewVersion];
//
//    if (firstOpenApp) {
//        UchainWelcomePageViewController *welcomePageViewController = [[UchainWelcomePageViewController alloc] init];
//        welcomePageViewController.didFinishScrollerWelcomeSub = [RACSubject subject];
//        [welcomePageViewController.didFinishScrollerWelcomeSub subscribeNext:^(id  _Nullable x) {
//            [self targetRootViewControllerSet];
//        }];
//
//        self.window.rootViewController = welcomePageViewController;
//    }
//    else {
//        [self targetRootViewControllerSet];
//    }
//
//    [UchainUtil configKeyBoard];
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
//    }
    [self targetRootViewControllerSet];
    [ApexAppConfig configAll];
    [self.window makeKeyAndVisible];
    
//    [self showWelcomePage];
    return YES;
}

- (void)targetRootViewControllerSet
{
    NSArray *arr = [[ETHWalletManager shareManager] getWalletsArr];
    BOOL isFirstCreatDone = ((NSNumber*)[TKFileManager ValueWithKey:KisFirstCreateWalletDone]).boolValue;
    
    if (arr.count == 0 && !isFirstCreatDone) {
        UchainWalletInitViewController *walletInitViewController = [[UchainWalletInitViewController alloc] init];
        walletInitViewController.didFinishCreatSub = [RACSubject subject];
        [walletInitViewController.didFinishCreatSub subscribeNext:^(id  _Nullable x) {
            self.window.rootViewController = _sideViewController;
        }];
        
        self.window.rootViewController = [[UchainNavigationViewController alloc] initWithRootViewController:walletInitViewController];
    }
    else {
        self.window.rootViewController = _sideViewController;
    }
}

- (BOOL)isOpenInNewVersion
{
    NSString *isOpenedApp = [[NSUserDefaults standardUserDefaults] objectForKey:@"is_open_app"];
    if (!isOpenedApp) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"is_open_app"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
    
    return NO;
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
