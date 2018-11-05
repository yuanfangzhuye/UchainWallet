//
//  UchainSideViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainSideViewController.h"
#import "UchainCreatWalletController.h"
#import "UchainImportWalletController.h"
#import "UchainNavigationViewController.h"

@interface UchainSideViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *leftItem;

@end

@implementation UchainSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _leftItem = self.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationItem.leftBarButtonItem = _leftItem;
}

- (void)initUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset([UchainUtil naviBarHeight]);
        make.right.bottom.equalTo(self.view);
        make.width.mas_equalTo(scaleWidth375(150));
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - ------delegate & datasource------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    NSArray *imgArray = @[@[@"icon-wallet-ETH"], @[@"icon-wallet-create", @"icon-wallet-import"]];
    NSArray *titleArray = @[@[@"ETH"], @[SOLocalizedStringFromTable(@"Create Wallet", nil), SOLocalizedStringFromTable(@"Import Wallet", nil)]];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [[imgArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60.0f;
    }
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        UchainNavigationViewController *navi = [UchainUtil goWalletTabBarController];
        if (indexPath.row == 0) {
            UchainCreatWalletController *createController = [[UchainCreatWalletController alloc] init];
            [navi pushViewController:createController animated:YES];
        }
        else if (indexPath.row == 1) {
            UchainImportWalletController *importController = [[UchainImportWalletController alloc] init];
            [navi pushViewController:importController animated:YES];
        }
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutManager:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    }
}

@end
