//
//  AppDelegate.h
//  UchainWallet
//
//  Created by 李超 on 2018/10/31.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarItem.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) YRSideViewController *sideViewController;
@property (nonatomic, strong) RDVTabBarController *mainTabBarController;
//@property (nonatomic, strong) UINavigationController *mainNavigationController;

+ (AppDelegate *)sharedApplicationDelegate;

@end

