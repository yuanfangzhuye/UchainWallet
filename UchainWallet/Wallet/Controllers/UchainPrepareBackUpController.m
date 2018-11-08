//
//  UchainPrepareBackUpController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainPrepareBackUpController.h"
#import "ApexBackUpController.h"
#import "UchainPassWordConfirmAlertView.h"

@interface UchainPrepareBackUpController ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *tipL;
@property (nonatomic, strong) UILabel *detailL;
@property (nonatomic, strong) UIButton *toBackUpBtn;

@end

@implementation UchainPrepareBackUpController

#pragma mark - ------life cycle------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
//    [self handleEvent];
}

#pragma mark - ------private------
- (void)initUI
{
    self.title = SOLocalizedStringFromTable(@"Backup Wallet", nil);
    
    [self.view addSubview:self.imageV];
    [self.view addSubview:self.tipL];
    [self.view addSubview:self.detailL];
    [self.view addSubview:self.toBackUpBtn];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset([UchainUtil naviBarHeight] + scaleHeight667(48));
        make.size.mas_equalTo(CGSizeMake(134.0f, 146.0f));
    }];
    
    [self.tipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV.mas_bottom).offset(40.0f);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(scaleWidth375(300), 30));
    }];
    
    CGFloat detailHEight = [UchainUtil calculateTextHeight:[UIFont systemFontOfSize:12] givenText:SOLocalizedStringFromTable(@"Export mnemonics and keep it in a safe place, do not save on the internet. then begin using with transfer small assets.", nil) givenWidth:scaleWidth375(300)];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipL.mas_bottom).offset(scaleHeight667(20.0f));
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(scaleWidth375(300), detailHEight));
    }];
    
    [self.toBackUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(iPhoneX ? 34.0F : 0));
    }];
    
    [self.toBackUpBtn addTarget:self action:@selector(backUpClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ------eventResponse------
//- (void)handleEvent{
//
//
//    [[self.toBackUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//
//    }];
//}

- (void)backUpClick:(id)sender
{
    NSString *keystore = [PDKeyChain load:[NSString stringWithFormat:@"%@", self.model.address]];
    NeomobileWallet *wallet = nil;
    NSError *err = nil;
    if (keystore) {
        wallet = NeomobileFromKeyStore(keystore, @"123456", &err);
    }
    
    if (err) {
        return;
    }
    ApexBackUpController *vc = [[ApexBackUpController alloc] init];
    vc.model = self.model;
    vc.mnemonic = [wallet mnemonic:mnemonicEnglish error:&err];
    vc.BackupCompleteBlock = self.BackupCompleteBlock;
    if (err) {
        [self showMessage:SOLocalizedStringFromTable(@"Create Mnemonics Failed", nil)];
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ------getter & setter------
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-prepare-wallet"]];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageV;
}

- (UILabel *)tipL{
    if (!_tipL) {
        _tipL = [[UILabel alloc] init];
        _tipL.font = [UIFont boldSystemFontOfSize:18];
        _tipL.text = SOLocalizedStringFromTable(@"Backup wallet mnemonic", nil);
        _tipL.textColor = [UIColor blackColor];
    }
    return _tipL;
}

- (UILabel *)detailL{
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.font = [UIFont systemFontOfSize:12];
        _detailL.text = SOLocalizedStringFromTable(@"Export mnemonics and keep it in a safe place, do not save on the internet. then begin using with transfer small assets.", nil);
        _detailL.numberOfLines = 0;
        _detailL.textColor = [UIColor blackColor];
    }
    return _detailL;
}

- (UIButton *)toBackUpBtn{
    if (!_toBackUpBtn) {
        _toBackUpBtn = [[UIButton alloc] init];
        [_toBackUpBtn setTitle:SOLocalizedStringFromTable(@"Backup now", nil) forState:UIControlStateNormal];
        [_toBackUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toBackUpBtn.backgroundColor = [UchainUtil mainThemeColor];
        _toBackUpBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        
    }
    return _toBackUpBtn;
}

@end
