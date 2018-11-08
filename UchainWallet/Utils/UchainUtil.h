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

+ (UIColor*)grayColor;

+ (UIColor *)mainThemeColor;

+ (UIView *)addLineInView:(UIView *)view color:(UIColor *)color edge:(UIEdgeInsets)edge;

+ (CGFloat)naviBarHeight;
+ (CGFloat)tabBarHeight;

//获取label的高度
+ (CGFloat)calculateTextHeight:(UIFont *)font givenText:(NSString *)text givenWidth:(CGFloat)width;
//获取label的宽度
+ (CGFloat)calculateTextLength:(UIFont *)font givenText:(NSString *)text;

+ (UchainNavigationViewController *)goWalletTabBarController;
+ (void)jumpToMainController:(UIViewController *)currentViewController;

+ (void)configKeyBoard;

@end

NS_ASSUME_NONNULL_END
