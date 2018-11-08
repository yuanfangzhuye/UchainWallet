//
//  UchainNewsViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainNewsViewController.h"
#import "UchainNewsTableViewCell.h"
#import "UchainNewModel.h"
#import "UchainNewsViewModel.h"

static CGFloat kMargin = 15;

@interface UchainNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UchainNewsViewModel *ucNewViewModel;

@end

@implementation UchainNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindingData];
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[[AppDelegate sharedApplicationDelegate] mainTabBarController] setTabBarHidden:NO animated:animated];
    [self initNavigationBar];
}

- (void)initNavigationBar
{
    [self.navigationController lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
}

#pragma mark - DataMethod

- (void)p_getData{
    [self.dataArray removeAllObjects];
    [self.tableView.mj_footer resetNoMoreData];
    
    [self.ucNewViewModel.tableCommand execute:nil];
    
//    UchainNewModel *newModel = [[UchainNewModel alloc]init];
//    newModel.cellTitle = @"特斯拉私有化后怎么样？看看SpaceX就知道了";
//    newModel.cellDate = @"08-18";
//    newModel.imageUrl = @"icon-wallet-selected";
//    [self.dataArray addObject:newModel];
    
//    [self.tableView.mj_header endRefreshing];
//    if(self.dataArray.count<20){
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    }
//    [self.tableView reloadData];
}

- (void)p_getFootdata{
    [self.ucNewViewModel.tableCommand execute:nil];

//    UchainNewModel *newModel = [[UchainNewModel alloc]init];
//    newModel.cellTitle = @"特斯拉私有化后怎么样？看看SpaceX就知道了?";
//    newModel.cellDate = @"08-18";
//    newModel.imageUrl = @"icon-wallet-selected";
//    NSArray *arr =@[newModel];
//
//    [self.dataArray addObjectsFromArray:arr];
//    [self.tableView.mj_footer endRefreshing];
//    if(arr.count < 20)
//    {
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    }
//    [self.tableView reloadData];
}

#pragma mark - BindingData

- (void)bindingData{
    [[[self.ucNewViewModel.tableCommand executionSignals] switchToLatest]subscribeNext:^(id  _Nullable x) {
        NSArray *array = x;
        [self.dataArray addObjectsFromArray:array];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if(array.count < 20)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];

    }];
}

#pragma mark - UI

-(void)creatUI{
    [self.view addSubview:self.backgroundImageView];

    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = SOLocalizedStringFromTable(@"NewsLetter", nil);
    topLabel.textColor = [UIColor whiteColor];
    topLabel.font = UWFont(17);
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(kMargin);
        make.top.equalTo(self.view.mas_top).with.offset(25 + StatusBarHeight);
    }];
    
    [self.view addSubview:self.tableView];

    [self p_getData];

    
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
    UchainNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.uchainNewModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110 + kMargin;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - getter

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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 78 + StatusBarHeight, kScreenWidth, kScreenHeight - StatusBarHeight - 78) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UchainNewsTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [self p_getFootdata];
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self p_getData];
        }];
        if(_dataArray.count<20){
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }return _dataArray;
}

- (UchainNewsViewModel *)ucNewViewModel{
    if (!_ucNewViewModel) {
        _ucNewViewModel = [[UchainNewsViewModel alloc]init];
    }return _ucNewViewModel;
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
