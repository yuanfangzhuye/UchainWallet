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

@end

@implementation WalletAddAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_creatUI];
}

#pragma mark - UI

- (void)p_creatUI{
    self.navigationItem.title = @"添加资产";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController lt_setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = NO;
    
}

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddAssetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin);

    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70 + kMargin;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
