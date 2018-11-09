//
//  UchainImportWalletController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainImportWalletController.h"

@interface UchainImportWalletController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UchainImportWalletController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController lt_setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = SOLocalizedStringFromTable(@"Import Wallet", nil);
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake((kScreenWidth - 100) / 2, 240, 100, 30);
    [nextBtn setTitle:@"导入" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UchainUtil mainThemeColor];
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick
{
    NSError *err = nil;
    EthmobileWallet *wallet = EthmobileFromMnemonic(@"demise chalk clean merit until circle vendor broccoli fitness diet arch anger unlock immune smoke foil intact leopard panic brisk oxygen napkin trophy result", mnemonicEnglish, &err);
    
    if (err) {
        [self showMessage:SOLocalizedStringFromTable(@"Import Wallet Failed", nil)];
        return;
    }
    
    NSError *keystoreErr = nil;
    NSString *keystore = [wallet toKeyStore:@"123456" error:&keystoreErr];
    if (keystoreErr) {
        [self showMessage:[NSString stringWithFormat:@"%@: %@",SOLocalizedStringFromTable(@"Create Keystore Failed", nil) ,keystoreErr]];
        return;
    }
    
    NSString *address = wallet.address;
    
    [PDKeyChain save:KEYCHAIN_KEY(address) data:keystore];
    [[ETHWalletManager shareManager] saveWallet:address name:@"Wallet"];
    
    [self showMessage:SOLocalizedStringFromTable(@"Import Wallet Success", nil)];
    
    if (self.didFinishImportSub) {
        [self.didFinishImportSub sendNext:@""];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
