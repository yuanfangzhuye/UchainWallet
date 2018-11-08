//
//  UchainNavigationViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/10/31.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainNavigationViewController.h"
#import "UchainSideViewController.h"

@interface UchainNavigationViewController () <UIGestureRecognizerDelegate>

@end

@implementation UchainNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.titleTextAttributes= [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    else {
        if ([self.topViewController isKindOfClass:[UchainSideViewController class]]) {
            return NO;
        }
        else {
            return YES;
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0) {
        [self.navigationBar setTintColor:[UIColor whiteColor]];
        UIImage *image = [UIImage imageNamed:@"icon-back-black"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image  style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        
    }
    [[[AppDelegate sharedApplicationDelegate] mainTabBarController] setTabBarHidden:YES animated:animated];
    [self findHairlineImageViewUnder:self.navigationBar].hidden = YES;
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
