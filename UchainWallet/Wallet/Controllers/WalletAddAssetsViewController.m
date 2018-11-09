//
//  WalletAddAssetsViewController.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "WalletAddAssetsViewController.h"
#import "AddAssetsTableViewCell.h"
static CGFloat kMargin = 15;

@interface WalletAddAssetsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentArr;

@end

@implementation WalletAddAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_createUI];
}

#pragma mark - UI

- (void)p_createUI{
    self.navigationItem.title = @"添加资产";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self prepareEthData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController lt_setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
    
}

#pragma mark - Data
- (void)prepareEthData{
    self.contentArr = [ETHAssetModelManage getLocalAssetModelsArr];
    ApexAssetModel *ethModel = nil;
    for (ApexAssetModel *model in [self.contentArr copy]) {
        if ([model.hex_hash isEqualToString:assetId_Eth]) {
            [self.contentArr removeObject:ethModel];
            ethModel = model;
            break;
        }
    }
    if(ethModel) [self.contentArr insertObject:ethModel atIndex:0];
    [self.tableView reloadData];
}

- (BOOL)verifyIsSelect:(ApexAssetModel*)model{
    for (BalanceObject *obj in self.walletAssetArr) {
        if ([model.hex_hash isEqualToString:obj.asset]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddAssetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    
    cell.model = self.contentArr[indexPath.row];
    cell.indicatorSelected = [self verifyIsSelect:cell.model];

    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ApexAssetModel *model = self.contentArr[indexPath.row];
//    if ([model.hex_hash isEqualToString:assetId_NeoGas] || [model.hex_hash isEqualToString:assetId_Neo] || [model.hex_hash isEqualToString:assetId_CPX]) {
//        return;
//    }
    
    AddAssetsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.indicatorSelected = !cell.indicatorSelected;
    if (cell.indicatorSelected) {
        [self.walletAssetArr addObject:[model convertToBalanceObject]];
    }else{
        [self.walletAssetArr removeObject:[model convertToBalanceObject]];
    }
}


#pragma mark - getter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[AddAssetsTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            //            [self p_getData];
        }];
        
    }return _tableView;
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
