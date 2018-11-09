//
//  UchainWalletViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainWalletViewController.h"
#import "UchainSideViewController.h"
#import "UchainNavigationViewController.h"
#import "UchainWalletTableViewCell.h"
#import "UchainAccountListViewController.h"

static CGFloat kMargin = 15;

#define RouteNameEvent_ShowMorePanel @"RouteNameEvent_ShowMorePanel"

@interface UchainWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UchainSideViewController *sideViewController;

@property (nonatomic, strong) UchainNavigationViewController *screenNavigationController;

@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation UchainWalletViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self p_creatUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[[AppDelegate sharedApplicationDelegate] mainTabBarController] setTabBarHidden:NO animated:animated];
    [self initNavigationBar];
    [self getWalletLists];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = NO;
}

- (void)initNavigationBar
{
    [self.navigationController lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
}

- (void)routeEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userinfo {
    if([eventName isEqualToString:RouteNameEvent_ShowMorePanel]){
        [self pushAction];
    }
}

- (void)pushAction {
    YRSideViewController *sideViewController = (YRSideViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).sideViewController;
    [sideViewController showRightViewController:YES];
}

#pragma mark - UI
- (void)p_creatUI{
    _dataArray = [NSMutableArray new];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFEDF2F5"];
    UIImageView *bannerImageView = [[UIImageView alloc]init];
    bannerImageView.image = [UIImage imageNamed:@"banner"];
    [self.view addSubview:bannerImageView];
    [bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bannerImageView.mas_bottom).with.offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
    self.tableView.mj_header = header;
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)getWalletLists
{
    _dataArray = [[ETHWalletManager shareManager] getWalletsArr];
    [self.tableView reloadData];
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UchainWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ETHWalletModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.walletName = model.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 + kMargin;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETHWalletModel *model = _dataArray[indexPath.row];
    UchainAccountListViewController *acountVC = [[UchainAccountListViewController alloc]init];
    acountVC.walletModel = model;
    [self.navigationController pushViewController:acountVC animated:YES];
}


#pragma mark - getter

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        _moreBtn.frame = CGRectMake(0, 0, 40, 40);
        [_moreBtn setImage:[UIImage imageNamed:@"icon-wallet-menu"] forState:UIControlStateNormal];
        [[_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self routeEventWithName:RouteNameEvent_ShowMorePanel userInfo:@{}];
        }];
    }
    return _moreBtn;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backgroundImageView.image = [UIImage imageNamed:@"walletBackgroundImage"];
    }
    
    return _backgroundImageView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UchainWalletTableViewCell class] forCellReuseIdentifier:@"cell"];

    }return _tableView;
}


@end
