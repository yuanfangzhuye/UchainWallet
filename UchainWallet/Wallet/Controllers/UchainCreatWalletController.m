//
//  UchainCreatWalletController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainCreatWalletController.h"
#import "UchainImportWalletController.h"
#import "UchainPrepareBackUpController.h"
#import "UchainProlicyController.h"

#import "ApexWalletManager.h"
#import "ETHWalletManager.h"

#import "UchainCreateBottomView.h"
#import "UchainCreateWalletTipsHeaderView.h"
#import "UchainPrivacyAgreeFooterView.h"
#import "UchainCreateWalletNameCell.h"
#import "UchainCreateWalletPasswordCell.h"

@interface UchainCreatWalletController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *navigationBarTitle;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UchainCreateBottomView *bottomView;

@property (nonatomic, strong) id createWalletModel;

@end

@implementation UchainCreatWalletController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-back-black"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    self.bottomView.importString = SOLocalizedStringFromTable(@"Import Wallet", nil);
    self.bottomView.createString = SOLocalizedStringFromTable(@"Confirm11", nil);
    
    [self.bottomView.createButton addTarget:self action:@selector(createWallet) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.importButton addTarget:self action:@selector(importWallet) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[UchainCreateWalletNameCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[UchainCreateWalletPasswordCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[UchainCreateWalletTipsHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.tableView registerClass:[UchainPrivacyAgreeFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset([UchainUtil naviBarHeight] + 20.0f);
        make.left.equalTo(self.view).with.offset(15.0f);
        make.right.equalTo(self.view).with.offset(-15.0f);
        make.bottom.equalTo(self.view).offset(-(iPhoneX ? 83.0f : 49.0f));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(iPhoneX ? 83.0f : 49.0f);
    }];
}

- (void)initNavigationBar
{
    self.navigationItem.titleView = self.navigationBarTitle;
}

#pragma mark ------ UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    else if (section == 2) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 70.0f;
    }
    else if (indexPath.section == 2) {
        return 140.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UchainCreateWalletTipsHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        return headerView;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UchainPrivacyAgreeFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        return footerView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [UchainCreateWalletTipsHeaderView getTipsContentHeight];
    }
    
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   if (section == 2) {
        return 40.0f;
    }
    
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        UchainCreateWalletNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.section == 2) {
        UchainCreateWalletPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return nil;
}

- (NSString *)getWalletName
{
    UchainCreateWalletNameCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    return cell.inputTextField.text;
}

- (NSString *)getWalletPassword
{
    UchainCreateWalletPasswordCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    return cell.passwordTextField.text;
}

- (NSString *)getRepeatPassword
{
    UchainCreateWalletPasswordCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    return cell.repeteTextField.text;
}

- (BOOL)getPrivacySelected
{
    UchainPrivacyAgreeFooterView *footerView = (UchainPrivacyAgreeFooterView *)[self.tableView footerViewForSection:2];
    return footerView.privacyAgreeBtn.selected;
}

- (void)routeEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userinfo
{
    if ([eventName isEqualToString:@"11111"]) {
        NSString *htmlString = [userinfo objectForKey:@"html"];
        
        UchainProlicyController *vc = [[UchainProlicyController alloc] init];
        vc.html = htmlString;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)createWallet
{
    NSString *walletNameString = [self getWalletName];
    NSString *PasswordString = [self getWalletPassword];
    NSString *repeatPasswordString = [self getRepeatPassword];
    
    if (walletNameString.length != 0 && PasswordString.length >= 6 && [repeatPasswordString isEqualToString:PasswordString] && [self getPrivacySelected]) {
        [self createETHWallet];
    }
}

- (void)importWallet
{
    UchainImportWalletController *importWalletController = [[UchainImportWalletController alloc] init];
    [self.navigationController pushViewController:importWalletController animated:YES];
}

- (void)createEthWalletWithPassword:(NSString *)password walletName:(NSString *)walletname
{
    [ETHWalletManager creatETHWalletSuccess:^(EthmobileWallet *wallet) {
        
        NSError *ksErr = nil;
        NSString *ks = [wallet toKeyStore:password error:&ksErr];
        if (ksErr) {
            [self showMessage:[NSString stringWithFormat:@"%@: %@",SOLocalizedStringFromTable(@"Create Keystore Failed", nil),ksErr]];
        }
        NSString *address = wallet.address;
        [PDKeyChain save:[NSString stringWithFormat:@"%@", address] data:ks];
        
        [[ETHWalletManager shareManager] saveWallet:address name:walletname];
        self.createWalletModel = wallet;
        
    } failed:^(NSError *error) {
        [self showMessage:[NSString stringWithFormat:@"%@",SOLocalizedStringFromTable(@"Create Wallet Failed", nil)]];
    }];
}

- (void)createETHWallet
{
    [self createEthWalletWithPassword:[self getWalletPassword] walletName:[self getWalletName]];
    UchainPrepareBackUpController *vc = [[UchainPrepareBackUpController alloc] init];
    EthmobileWallet *wallet = (EthmobileWallet*)_createWalletModel;
    
    NSArray *walletArray = [[ETHWalletManager shareManager] getWalletsArr];
    for (ETHWalletModel *model in walletArray) {
        if ([model.address isEqualToString:wallet.address]) {
            vc.model = model;
            break;
        }
    }
    
    if (_createWalletModel == nil) {
        return;
    }
    
    vc.isFromCreat = YES;
    vc.BackupCompleteBlock = ^{
        if (self.didFinishCreatSub) {
            [self.didFinishCreatSub sendNext:@""];
        }
    };
//    [self directlyPushToViewControllerWithSelfDeleted:vc];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ------ getter,setter

- (UILabel *)navigationBarTitle
{
    if (!_navigationBarTitle) {
        _navigationBarTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        _navigationBarTitle.text = SOLocalizedStringFromTable(@"Create Wallet", nil);
        _navigationBarTitle.textAlignment = NSTextAlignmentCenter;
        _navigationBarTitle.textColor = [UIColor blackColor];
    }
    return _navigationBarTitle;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UchainCreateBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UchainCreateBottomView alloc] init];
    }
    
    return _bottomView;
}

@end
