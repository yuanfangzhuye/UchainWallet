//
//  UchainMineViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainMineViewController.h"
#import "UchainLanguageSettingController.h"

@interface UchainMineViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation UchainMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundImageView];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(50, 50, 100, 100);
//    btn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(id)sender
{
    UchainLanguageSettingController *languageSettingController = [[UchainLanguageSettingController alloc] init];
    [self.navigationController pushViewController:languageSettingController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[[AppDelegate sharedApplicationDelegate] mainTabBarController] setTabBarHidden:NO animated:animated];
    [self initNavigationBar];
}

- (void)initNavigationBar
{
    [self.navigationController lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
}

#pragma mark ------ getter

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backgroundImageView.image = [UIImage imageNamed:@"walletBackgroundImage"];
    }
    
    return _backgroundImageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
