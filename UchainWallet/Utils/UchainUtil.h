//
//  UchainUtil.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UchainNavigationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UchainUtil : NSObject

+ (UIColor *)tabBarColor;

+ (UIColor *)tabBarSelectedColor;

+ (UIColor *)mainThemeColor;

+ (UIView *)addLineInView:(UIView *)view color:(UIColor *)color edge:(UIEdgeInsets)edge;

+ (CGFloat)naviBarHeight;
+ (CGFloat)tabBarHeight;

+ (UchainNavigationViewController *)goWalletTabBarController;
+ (void)jumpToMainController:(UIViewController *)currentViewController;

@end

NS_ASSUME_NONNULL_END
