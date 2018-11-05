//
//  UIViewController+UchainNavigationColor.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UIViewController+UchainNavigationColor.h"
#import "UchainMethodSwizzlingUtil.h"

@implementation UIViewController (UchainNavigationColor)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [UchainMethodSwizzlingUtil methodSwizzle:self origin:@selector(viewWillDisappear:) new:@selector(uchain_viewWillDisappear:)];
        [UchainMethodSwizzlingUtil methodSwizzle:self origin:@selector(viewDidLoad) new:@selector(uchain_viewDidLoad)];
        
    });
}

- (void)uchain_viewWillDisappear:(BOOL)animated
{
    [self.navigationController lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self uchain_viewWillDisappear:animated];
}

- (void)uchain_viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self uchain_viewDidLoad];
}

@end
