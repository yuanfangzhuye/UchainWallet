//
//  UchainPassWordConfirmAlertView.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainPassWordConfirmAlertView.h"
#import "FCAlertView.h"

@implementation UchainPassWordConfirmAlertView

+ (void)showDeleteConfirmAlertAddress:(NSString *)address subTitle:(NSString*)subtitle Success:(successBlock)success fail:(dispatch_block_t)fail{
    FCAlertView *alert = [[FCAlertView alloc] init];
    UITextField *customField = [[UITextField alloc] init];
    customField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    customField.font = [UIFont systemFontOfSize:13];
    customField.borderStyle = UITextBorderStyleRoundedRect;
    customField.secureTextEntry = YES;
    customField.layer.borderColor = [UchainUtil grayColor].CGColor;
    [customField becomeFirstResponder];
    __block NSString *password = nil;
    [alert addTextFieldWithCustomTextField:customField andPlaceholder:SOLocalizedStringFromTable(@"Password", nil) andTextReturnBlock:^(NSString *text) {
        password = text;
    }];
    NSString *tip = @"";
    [[SOLocalization sharedLocalization].region isEqualToString:SOLocalizationEnglish] ? (tip = @"Password") : (tip = @"请输入密码");
    
    [alert showAlertWithTitle:tip withSubtitle:subtitle withCustomImage:nil withDoneButtonTitle:SOLocalizedStringFromTable(@"Confirm", nil) andButtons:@[SOLocalizedStringFromTable(@"Cancle", nil)]];
    
    if (subtitle.length > 0) {
        alert.doneButtonTitleColor = [UIColor redColor];
    }
    
    [alert doneActionBlock:^{
        [customField resignFirstResponder];
        NSString *keystore = [PDKeyChain load:[NSString stringWithFormat:@"%@", address]];
        NeomobileWallet *wallet = nil;
        NSError *err = nil;
        if (keystore) {
            wallet = NeomobileFromKeyStore(keystore, password, &err);
        }
        
        if (err) {
            if (fail) {
                fail();
            }
            return;
        }
        
        if (success) {
            success(wallet);
        }
    }];
}

+ (void)showEntryPasswordAlertAddress:(NSString *)address walletManager:(id<ApexWalletManagerProtocal>)manager subTitle:(NSString*)subtitle Success:(successBlock)success fail:(dispatch_block_t)fail{
    FCAlertView *alert = [[FCAlertView alloc] init];
    UITextField *customField = [[UITextField alloc] init];
    customField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    customField.font = [UIFont systemFontOfSize:13];
    customField.borderStyle = UITextBorderStyleRoundedRect;
    customField.secureTextEntry = YES;
    customField.layer.borderColor = [UchainUtil grayColor].CGColor;
    [customField becomeFirstResponder];
    __block NSString *password = nil;
    [alert addTextFieldWithCustomTextField:customField andPlaceholder:SOLocalizedStringFromTable(@"Password", nil) andTextReturnBlock:^(NSString *text) {
        password = text;
    }];
    NSString *tip = @"";
    [[SOLocalization sharedLocalization].region isEqualToString:SOLocalizationEnglish] ? (tip = @"Password") : (tip = @"请输入密码");
    [alert showAlertWithTitle:tip withSubtitle:subtitle withCustomImage:nil withDoneButtonTitle:SOLocalizedStringFromTable(@"Confirm", nil) andButtons:@[SOLocalizedStringFromTable(@"Cancle", nil)]];
    
    [alert doneActionBlock:^{
        [customField resignFirstResponder];
        NSString *keystore = [PDKeyChain load:[NSString stringWithFormat:@"%@", address]];
        if (keystore) {
            [manager WalletFromKeystore:keystore password:password success:^(id wallet) {
                if (success) {
                    success(wallet);
                }
            } failed:^(NSError *error) {
                if (error) {
                    if (fail) {
                        fail();
                    }
                }
            }];
        }
    }];
}

@end
