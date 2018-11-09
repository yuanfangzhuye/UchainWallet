//
//  UchainPayTransferViewController.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/9.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainPayTransferViewController.h"
#import "WalletBalanceView.h"

static CGFloat kMargin = 15;

@interface UchainPayTransferViewController ()

@end

@implementation UchainPayTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_createUI];
}

#pragma mark - UI
- (void)p_createUI{
    WalletBalanceView *balanceView = [[WalletBalanceView alloc]initWithFrame:CGRectMake(kMargin, kMargin + StatusBarAndNavigationBarHeight, kScreenWidth - kMargin*2, 120) withTypeName:@"ETH" withBalance:@"0.0000"];
    [self.view addSubview:balanceView];
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
