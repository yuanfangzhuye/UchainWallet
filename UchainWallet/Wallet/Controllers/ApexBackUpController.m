//
//  ApexBackUpController.m
//  Apex
//
//  Created by chinapex on 2018/5/24.
//  Copyright © 2018年 Chinapex. All rights reserved.
//

#import "ApexBackUpController.h"
#import "ApexMnemonicConfirmController.h"

@interface ApexBackUpController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) UILabel *tipLable01;
@property (nonatomic, strong) UILabel *tipLabel2;
@property (nonatomic, strong) UILabel *tipLable3;

@end

@implementation ApexBackUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SOLocalizedStringFromTable(@"Backup Wallet", nil);
    
    [self initUI];
    [self handleEvent];
}

- (void)initUI
{
    CGFloat tipHeight = [UchainUtil calculateTextHeight:[UIFont systemFontOfSize:12] givenText:SOLocalizedStringFromTable(@"The mnemonic is used to recover the wallet or repeat the wallet password, copy it to the paper accurately, and store it in a safe place that only you know.", nil) givenWidth:(kScreenWidth - 60.0f)];
    
    CGFloat tipHeight2 = [UchainUtil calculateTextHeight:[UIFont systemFontOfSize:12] givenText:SOLocalizedStringFromTable(@"Do not take screenshots,  someone will have fully accecss to your assets ,if it gets your mnemonic! Please copy the mnemonic, then store it at a safe place.", nil) givenWidth:(kScreenWidth - 60.0f)];
    
    [self.view addSubview:self.tipLable01];
    [self.view addSubview:self.tipLabel2];
    [self.view addSubview:self.tipLable3];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.nextBtn];
    
    [self.tipLable01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30.0f);
        make.right.equalTo(self.view).with.offset(-30.0f);
        make.top.equalTo(self.view).offset([UchainUtil naviBarHeight] + scaleHeight667(48));
        make.height.mas_equalTo(30.0f);
    }];
    
    [self.tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30.0f);
        make.right.equalTo(self.view).with.offset(-30.0f);
        make.top.equalTo(self.tipLable01.mas_bottom).with.offset(10.0f);
        make.height.mas_equalTo(tipHeight);
    }];
    
    [self.tipLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30.0f);
        make.right.equalTo(self.view).with.offset(-30.0f);
        make.top.equalTo(self.tipLabel2.mas_bottom).with.offset(10.0f);
        make.height.mas_equalTo(tipHeight2);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30.0f);
        make.right.equalTo(self.view).with.offset(-30.0f);
        make.top.equalTo(self.tipLable3.mas_bottom).with.offset(10.0f);
        make.height.mas_equalTo(120.0f);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(iPhoneX ? 34.0F : 0));
    }];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.textView.text attributes:attributes];
}

- (void)handleEvent
{
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ApexMnemonicConfirmController *vc = [[ApexMnemonicConfirmController alloc] init];
        vc.mnemonic = self.mnemonic;
        vc.model = self.model;
        vc.BackupCompleteBlock = self.BackupCompleteBlock;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (UILabel *)tipLable01
{
    if (!_tipLable01) {
        _tipLable01 = [[UILabel alloc] init];
        _tipLable01.font = [UIFont boldSystemFontOfSize:20];
        _tipLable01.textColor = [UIColor blackColor];
        _tipLable01.text = SOLocalizedStringFromTable(@"Copy your wallet mnemonic", nil);
    }
    
    return _tipLable01;
}

- (UILabel *)tipLabel2
{
    if (!_tipLabel2) {
        _tipLabel2 = [[UILabel alloc] init];
        _tipLabel2.font = [UIFont systemFontOfSize:12];
        _tipLabel2.textColor = [UIColor blackColor];
        _tipLabel2.numberOfLines = 0;
        _tipLabel2.text = SOLocalizedStringFromTable(@"The mnemonic is used to recover the wallet or repeat the wallet password, copy it to the paper accurately, and store it in a safe place that only you know.", nil);
    }
    
    return _tipLabel2;
}

- (UILabel *)tipLable3
{
    if (!_tipLable3) {
        _tipLable3 = [[UILabel alloc] init];
        _tipLable3.font = [UIFont systemFontOfSize:12];
        _tipLable3.textColor = [UIColor blackColor];
        _tipLable3.numberOfLines = 0;
        _tipLable3.text = SOLocalizedStringFromTable(@"Do not take screenshots,  someone will have fully accecss to your assets ,if it gets your mnemonic! Please copy the mnemonic, then store it at a safe place.", nil);
    }
    
    return _tipLable3;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor colorWithRed:238/255.0 green:249/255.0 blue:255/255.0 alpha:1];
        _textView.layer.cornerRadius = 3;
        _textView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        _textView.layer.shadowOffset = CGSizeMake(0, 1);
        _textView.layer.shadowOpacity = 0.63;
        _textView.userInteractionEnabled = NO;
        _textView.text = self.mnemonic;
    }
    
    return _textView;
}

- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:SOLocalizedStringFromTable(@"Next step", nil) forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.backgroundColor = [UchainUtil mainThemeColor];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _nextBtn;
}


@end
