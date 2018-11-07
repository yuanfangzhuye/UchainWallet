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

+ (UIColor*)grayColor
{
    return [UIColor colorWithRed255:200 green255:200 blue255:200 alpha:1];
}

+ (UIColor *)mainThemeColor
{
    return [UIColor colorWithHexString:@"00BDFF"];
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

+ (CGFloat)calculateTextHeight:(UIFont *)font givenText:(NSString *)text givenWidth:(CGFloat)width
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 9999) options:
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:attribute context:nil];
    CGFloat height = rect.size.height + 1.0f;
    
    return height;
}

+ (CGFloat)calculateTextLength:(UIFont *)font givenText:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:
                        NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                       attributes:attribute context:nil].size;
    CGFloat length = titleSize.width + 1.0f;
    
    return length;
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

+ (void)configKeyBoard
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

@end
