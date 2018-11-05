//
//  AppDelegate+UchainUI.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "AppDelegate+UchainUI.h"
#import "UchainSideViewController.h"
#import "UchainNavigationViewController.h"
#import "UchainWalletViewController.h"
#import "UchainNewsViewController.h"
#import "UchainMineViewController.h"

@implementation AppDelegate (UchainUI)

- (void)initWindowsRootViewController
{
    UchainWalletViewController *walletViewController = [[UchainWalletViewController alloc] init];
    UchainNavigationViewController *walletNavigationViewController = [[UchainNavigationViewController alloc] initWithRootViewController:walletViewController];
    
    UchainNewsViewController *newsViewController = [[UchainNewsViewController alloc] init];
    UchainNavigationViewController *newsNavigationViewController = [[UchainNavigationViewController alloc] initWithRootViewController:newsViewController];
    
    UchainMineViewController *mineViewController = [[UchainMineViewController alloc] init];
    UchainNavigationViewController *mineNavigationViewController = [[UchainNavigationViewController alloc] initWithRootViewController:mineViewController];
    
    self.mainTabBarController = [[RDVTabBarController alloc] init];
    [self.mainTabBarController setViewControllers:@[walletNavigationViewController, newsNavigationViewController, mineNavigationViewController]];
    [self customizeTabBarOutlook];
    
    UchainSideViewController *sideViewController = [[UchainSideViewController alloc] init];
    
    self.sideViewController = [[YRSideViewController alloc] initWithNibName:nil bundle:nil];
    self.sideViewController.rootViewController = self.mainTabBarController;
    self.sideViewController.rightViewController = sideViewController;
    
    self.sideViewController.rightViewShowWidth = scaleWidth375(150);
    //阴影边框
    self.sideViewController.showBoundsShadow = NO;
    //默认不开启的可滑动展示
    self.sideViewController.needSwipeShowMenu = NO;
    //动画效果可以被自己自定义，具体请看api
    [self.sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        //使用简单的平移动画
        rootView.frame = CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
}

- (void)customizeTabBarOutlook
{
    UIImage *finishedImage = [self imageFromColor:[UIColor whiteColor]];
    
    NSArray *tabBarItemSelectImages = @[@"icon-wallet-selected", @"icon-encurage-selected", @"icon-mine-selected"];
    NSArray *tabBarItemDisSelectImages = @[@"icon-wallet", @"icon-encurage", @"icon-mine"];
    NSArray *titleArray = @[@"", @"", @""];
    
    NSDictionary *selectAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UchainUtil mainThemeColor]};
    NSDictionary *deselectAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1]};
    
    NSArray *tabItemsArray = [[self.mainTabBarController tabBar] items];
    
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

@end
