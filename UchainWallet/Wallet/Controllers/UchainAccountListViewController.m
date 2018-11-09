//
//  UchainAccountListViewController.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainAccountListViewController.h"
#import "UchainAccountListCell.h"
#import "UchainOperateWalletViewController.h"

#import "WalletAddAssetsViewController.h"

static CGFloat kMargin = 15;

@interface UchainAccountListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *assetArr;
@property (nonatomic, strong) NSMutableDictionary *assetMap; //资产对应的余额字典

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation UchainAccountListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_createUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController lt_setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController lt_setBackgroundColor:[UIColor whiteColor]];
    [self requestETHAsset];
}

#pragma mark - UI

- (void)p_createUI{
    self.navigationItem.title = @"Oamul Lu的钱包";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addBtn];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFEDF2F5"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self requestETHAsset];
    }];
    self.tableView.mj_header = header;
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

#pragma mark - 获取钱包ETH资产
- (void)getLoacalEthAsset{
    self.title = self.walletModel.name;
    self.assetArr = self.walletModel.assetArr;
    [self.tableView reloadData];
    [self creataAssetMap];
}

- (void)creataAssetMap{
    self.assetMap = [NSMutableDictionary dictionary];
    for (BalanceObject *balance in self.assetArr) {
        [self.assetMap setValue:balance.value forKey:balance.asset];
    }
}

- (void)requestETHAsset{
    [self getLoacalEthAsset];
    
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [ETHWalletManager requestETHBalanceOfAddress:self.walletModel.address success:^(AFHTTPRequestOperation *operation, NSString *responseObject) {
            
            BalanceObject *obj = [BalanceObject new];
            obj.asset = assetId_Eth;
            obj.value = responseObject;
            [subscriber sendNext:@{assetId_Eth:obj}];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (self.assetArr.count <= 1) [subscriber sendNext:dict];
        for (BalanceObject *obj in self.assetArr) {
            //非eth
            if (![obj.asset isEqualToString:assetId_Eth]) {
                ApexAssetModel *assetModel = [obj getRelativeETHAssetModel];
                
                [ETHWalletManager requestERC20BalanceOfContract:obj.asset Address:self.walletModel.address decimal:assetModel.precision success:^(AFHTTPRequestOperation *operation, NSString *responseObject) {
                    obj.value = responseObject;
                    [dict setObject:obj forKey:obj.asset];
                    if (dict.allKeys.count == self.assetArr.count - 1) {
                        [subscriber sendNext:dict];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [subscriber sendError:error];
                }];
            }
        }
        return nil;
    }];
    
    RACSignal *combineSig = [RACSignal combineLatest:@[request1,request2] reduce:^id(NSDictionary *eth, NSDictionary *erc20){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addEntriesFromDictionary:eth];
        [dict addEntriesFromDictionary:erc20];
        return dict;
    }];
    
    [[self rac_liftSelector:@selector(updateEthAndErc20:) withSignals:combineSig, nil] subscribeError:^(NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
        [self showMessage:SOLocalizedStringFromTable(@"Request Failed, Please Check Your Network Status", nil)];
    }];
}

- (void)updateEthAndErc20:(NSDictionary*)dict{
    [self.tableView.mj_header endRefreshing];
    for (BalanceObject *obj in self.assetArr) {
        obj.value = ((BalanceObject*)dict[obj.asset]).value;
    }
    
    [[ETHWalletManager shareManager] updateWallet:self.walletModel WithAssetsArr:self.assetArr];
    [self.tableView reloadData];
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = self.assetArr.count;
    return count == 0 ? 1 : count;;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UchainAccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.assetArr[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70 + kMargin;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UchainOperateWalletViewController *operateWalletViewController = [[UchainOperateWalletViewController alloc] init];
    operateWalletViewController.model = self.walletModel;
    [self.navigationController pushViewController:operateWalletViewController animated:YES];
}

#pragma mark - getter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UchainAccountListCell class] forCellReuseIdentifier:@"cell"];
        
    }return _tableView;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        [_addBtn setImage:[UIImage imageNamed:@"acountwallet-navbtn-plus"] forState:UIControlStateNormal];
        [[_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            UWLog(@"ClickAddBtn");
            WalletAddAssetsViewController *addAssetsVC = [[WalletAddAssetsViewController alloc]init];
            [self.navigationController pushViewController:addAssetsVC animated:YES];
        }];
        
    }return _addBtn;
}

- (NSMutableArray *)assetArr{
    if (!_assetArr) {
        _assetArr = [NSMutableArray array];
    }
    return _assetArr;
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
