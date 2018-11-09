//
//  UchainOperateWalletViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/9.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainOperateWalletViewController.h"
#import "UchainCreateBottomView.h"
#import "UchainPassWordConfirmAlertView.h"
#import "UchainPrepareBackUpController.h"

@interface UchainOperateWalletViewController ()

@property (nonatomic, strong) UILabel *walletTitleLabel;
@property (nonatomic, strong) ApexAlertTextField *walletnameTextField;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UchainCreateBottomView *bottomView;

@property (nonatomic, strong) id<ApexWalletManagerProtocal> walletManager;

@end

@implementation UchainOperateWalletViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController lt_setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    [self handleEvent];
}

- (void)initUI
{
    self.title = _model.name;
    
    [self.view addSubview:self.walletTitleLabel];
    [self.view addSubview:self.walletnameTextField];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.confirmButton];
    [self.view addSubview:self.bottomView];
    
    self.bottomView.importString = SOLocalizedStringFromTable(@"Delete Wallet", nil);
    self.bottomView.createString = SOLocalizedStringFromTable(@"Backup Mnemonic", nil);
    
    [self.walletTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30.0f);
        make.right.equalTo(self.view).with.offset(-30.0f);
        make.top.equalTo(self.view).with.offset([UchainUtil naviBarHeight] + 25.0f);
        make.height.mas_equalTo(35.0f);
    }];
    
    [self.walletnameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.walletTitleLabel);
        make.top.equalTo(self.walletTitleLabel.mas_bottom).with.offset(25.0f);
        make.height.mas_equalTo(45.0f);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30.0f);
        make.top.equalTo(self.walletnameTextField.mas_bottom).with.offset(25.0f);
        make.size.mas_equalTo(CGSizeMake(45.0f, 45.0f));
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-30.0f);
        make.top.equalTo(self.walletnameTextField.mas_bottom).with.offset(25.0f);
        make.size.mas_equalTo(CGSizeMake(45.0f, 45.0f));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(iPhoneX ? 83.0f : 49.0f);
    }];
    
    self.walletnameTextField.text = _model.name;
    _walletManager = [ETHWalletManager shareManager];
}

- (void)handleEvent
{
    @weakify(self);
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSString *name = self.walletnameTextField.text;
        if (name.length == 0 ) {
            [self showMessage:SOLocalizedStringFromTable(@"Please Input Wallet Name", nil)];
            return;
        }
        
        if (name.length > 8) {
            [self showMessage:SOLocalizedStringFromTable(@"longName", nil)];
            return;
        }
        
        [_walletManager changeWalletName:name forAddress:self.model.address];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.bottomView.importButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //删除钱包
        [self showDeleteConfirmAlert];
    }];
    
    [[self.bottomView.createButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //备份助记词
        UchainPrepareBackUpController *vc = [[UchainPrepareBackUpController alloc] init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)showDeleteConfirmAlert{
    @weakify(self);
    [UchainPassWordConfirmAlertView showDeleteConfirmAlertAddress:self.model.address subTitle:SOLocalizedStringFromTable(@"Attention! Delete Wallet Can Not Be Revoked", nil) Success:^(NeomobileWallet *wallet) {
        
        @strongify(self);
        [_walletManager deleteWalletForAddress:self.model.address];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    } fail:^{
        [self showMessage:SOLocalizedStringFromTable(@"Password Error",nil)];
    }];
}

#pragma ------ getter,setter

- (UILabel *)walletTitleLabel
{
    if (!_walletTitleLabel) {
        _walletTitleLabel = [[UILabel alloc] init];
        _walletTitleLabel.font = [UIFont systemFontOfSize:25];
        _walletTitleLabel.text = SOLocalizedStringFromTable(@"Wallet Name", nil);
        _walletTitleLabel.textColor = [UIColor blackColor];
    }
    return _walletTitleLabel;
}

- (ApexAlertTextField *)walletnameTextField
{
    if (!_walletnameTextField) {
        _walletnameTextField = [[ApexAlertTextField alloc] initWithFrame:CGRectZero];
        _walletnameTextField.font = [UIFont systemFontOfSize:13];
        _walletnameTextField.floatingLabelYPadding = 5;
        // 浮动式标签的正常字体颜色
        _walletnameTextField.floatingLabelTextColor = [UIColor colorWithHexString:@"555555"];
        // 输入框成为第一响应者时,浮动标签的文字颜色.
        _walletnameTextField.floatingLabelActiveTextColor = [UchainUtil mainThemeColor];
        // 指明当输入文字时,是否下调基准线(baseline).设置为YES(非默认值),意味着占位内容会和输入内容对齐.
        _walletnameTextField.keepBaseline = YES;
        // 设置占位符文字和浮动式标签的文字.
        [_walletnameTextField setPlaceholder:SOLocalizedStringFromTable(@"Please input", nil)
                     floatingTitle:SOLocalizedStringFromTable(@"", nil)];
        _walletnameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _walletnameTextField.alertString = SOLocalizedStringFromTable(@"1-12 characters", nil);
        _walletnameTextField.alertShowConditionBlock = ^BOOL(NSString *text) {
            if ((text.length > 0) && (text.length < 12)) {
                return NO;
            }
            return YES;
        };
    }
    return _walletnameTextField;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor colorWithHexString:@"D8E2E8"];
        _cancelButton.layer.cornerRadius = 22.5f;
        _cancelButton.clipsToBounds = YES;
        [_cancelButton setImage:[UIImage imageNamed:@"icon-arrow-back"] forState:UIControlStateNormal];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.backgroundColor = [UIColor colorWithHexString:@"00A8FF"];
        _confirmButton.layer.cornerRadius = 22.5f;
        _confirmButton.clipsToBounds = YES;
        [_confirmButton setImage:[UIImage imageNamed:@"icon-check-confirm"] forState:UIControlStateNormal];
    }
    return _confirmButton;
}

- (UchainCreateBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UchainCreateBottomView alloc] init];
    }
    return _bottomView;
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
