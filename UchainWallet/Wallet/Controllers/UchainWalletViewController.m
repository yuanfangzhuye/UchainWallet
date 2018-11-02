//
//  UchainWalletViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainWalletViewController.h"
#import "UchainSideViewController.h"
#import "UchainNavigationViewController.h"

#define RouteNameEvent_ShowMorePanel @"RouteNameEvent_ShowMorePanel"

@interface UchainWalletViewController ()

@property (nonatomic, strong) UchainSideViewController *sideViewController;
@property (nonatomic, strong) UchainNavigationViewController *screenNavigationController;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation UchainWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundImageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[[AppDelegate sharedApplicationDelegate] mainTabBarController] setTabBarHidden:NO animated:animated];
    [self initNavigationBar];
}

- (void)initNavigationBar
{
    [self.navigationController lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
}

- (void)routeEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userinfo {
    if([eventName isEqualToString:RouteNameEvent_ShowMorePanel]){
        [self pushAction];
    }
}

- (void)pushAction {
    YRSideViewController *sideViewController = (YRSideViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).sideViewController;
    [sideViewController showRightViewController:YES];
}

#pragma mark ------ getter

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        _moreBtn.frame = CGRectMake(0, 0, 40, 40);
        [_moreBtn setImage:[UIImage imageNamed:@"icon-wallet-menu"] forState:UIControlStateNormal];
        [[_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self routeEventWithName:RouteNameEvent_ShowMorePanel userInfo:@{}];
        }];
    }
    return _moreBtn;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backgroundImageView.image = [UIImage imageNamed:@"walletBackgroundImage"];
    }
    
    return _backgroundImageView;
}

@end
