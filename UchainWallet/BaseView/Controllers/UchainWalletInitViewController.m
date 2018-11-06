//
//  UchainWalletInitViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainWalletInitViewController.h"
#import "UchainCreatWalletController.h"
#import "UchainImportWalletController.h"

#define RouteEventName_CreatWallet @"RouteEventName_CreatWallet"
#define RouteEventName_ImportWallet @"RouteEventName_ImportWallet"

@interface UchainWalletInitViewController ()

@property (nonatomic, strong) UIButton *creatWalletBtn;
@property (nonatomic, strong) UIButton *importWalletBtn;

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *logoImageView;

@end

@implementation UchainWalletInitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillDisappear:animated];
}

#pragma mark - private
- (void)initUI {
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.creatWalletBtn];
    [self.view addSubview:self.importWalletBtn];
    [self.view addSubview:self.logoImageView];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scaleHeight667(174));
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(194);
        make.height.mas_equalTo(45);
    }];
    
    [self.creatWalletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.logoImageView).offset(scaleHeight667(220));
        make.width.mas_equalTo(scaleWidth375(200));
        make.height.mas_equalTo(scaleHeight667(40));
    }];
    
    [self.importWalletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.creatWalletBtn.mas_bottom).offset(15);
        make.width.mas_equalTo(scaleWidth375(200));
        make.height.mas_equalTo(scaleHeight667(40));
    }];
    
    if (@available(iOS 10.0, *)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)routeEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userinfo{
    if ([eventName isEqualToString:RouteEventName_CreatWallet]) {
        /**< 创建钱包 */
        UchainCreatWalletController *cwvc = [[UchainCreatWalletController alloc] init];
        cwvc.didFinishCreatSub = self.didFinishCreatSub;
        [self.navigationController pushViewController:cwvc animated:YES];
        
    }
    else {
        /**< 导入钱包 */
        UchainImportWalletController *iwvc = [[UchainImportWalletController alloc] init];
        iwvc.didFinishImportSub = self.didFinishCreatSub;
        [self.navigationController pushViewController:iwvc animated:YES];
        
    }
    
    [super routeEventWithName:eventName userInfo:userinfo];
}

#pragma mark - public

#pragma mark - delegate & datasource

#pragma mark - getter & setter
- (UIButton *)creatWalletBtn{
    if (!_creatWalletBtn) {
        _creatWalletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _creatWalletBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _creatWalletBtn.backgroundColor = [UchainUtil mainThemeColor];
        [_creatWalletBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_creatWalletBtn setTitle:SOLocalizedStringFromTable(@"Create Wallet", nil) forState:UIControlStateNormal];
        _creatWalletBtn.layer.cornerRadius = 4;
        [[[_creatWalletBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self routeEventWithName:RouteEventName_CreatWallet userInfo:@{}];
        }];
    }
    return _creatWalletBtn;
}

- (UIButton *)importWalletBtn{
    if (!_importWalletBtn) {
        _importWalletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _importWalletBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _importWalletBtn.backgroundColor = [UIColor clearColor];
        _importWalletBtn.layer.borderWidth = 1.0f;
        _importWalletBtn.layer.borderColor = [UchainUtil mainThemeColor].CGColor;
        [_importWalletBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_importWalletBtn setTitle:SOLocalizedStringFromTable(@"Import Wallet", nil) forState:UIControlStateNormal];
        _importWalletBtn.layer.cornerRadius = 4;
        [[[_importWalletBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self routeEventWithName:RouteEventName_ImportWallet userInfo:@{}];
        }];
    }
    return _importWalletBtn;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _backgroundImageView.image = [UIImage imageNamed:@"walletBackgroundImage"];
    }
    return _backgroundImageView;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    }
    return _logoImageView;
}

@end
