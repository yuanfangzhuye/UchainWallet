//
//  UchainCreatWalletController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainCreatWalletController.h"
#import "UchainImportWalletController.h"
#import "UchainWalletManager.h"

#define RouteEventName_CallCreatWalletApi @"RouteEventName_CallCreatWalletApi"
#define RouteNameEvent_GoToImportWallet @"RouteNameEvent_GoToImportWallet"

@interface UchainCreatWalletController ()

@end

@implementation UchainCreatWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)createEthWalletWithPassword:(NSString *)password walletName:(NSString *)walletname
{
    [UchainWalletManager creatETHWalletSuccess:^(EthmobileWallet *wallet) {
        
        NSError *ksErr = nil;
        NSString *ks = [wallet toKeyStore:@"" error:&ksErr];
        if (ksErr) {
            [self showMessage:[NSString stringWithFormat:@"%@: %@",SOLocalizedStringFromTable(@"Create Keystore Failed", nil),ksErr]];
        }
        NSString *address = wallet.address;
        [PDKeyChain save:[NSString stringWithFormat:@"%@", address] data:ks];
        
//        [[UchainWalletManager shareInstanceManager] saveWallet:address name:walletname];
//        self.createdWallet = wallet;
    } failed:^(NSError *error) {
        [self showMessage:[NSString stringWithFormat:@"%@",SOLocalizedStringFromTable(@"Create Wallet Failed", nil)]];
    }];
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
