//
//  UchainPayTransferViewController.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/9.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainPayTransferViewController.h"
#import "WalletBalanceView.h"
#import "TransactionHistoryCell.h"

static CGFloat kMargin = 15;

@interface UchainPayTransferViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *payBtn;

@property (nonatomic, strong) UIButton *transferBtn;



@end

@implementation UchainPayTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_createUI];
}

#pragma mark - UI
- (void)p_createUI{
    self.navigationItem.title = @"Oamul Lu的钱包";
    WalletBalanceView *balanceView = [[WalletBalanceView alloc]initWithFrame:CGRectMake(kMargin, kMargin + StatusBarAndNavigationBarHeight, kScreenWidth - kMargin*2, 120) withTypeName:@"ETH" withBalance:@"0.0000"];
    [self.view addSubview:balanceView];
    
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    topLabel.text = @"交易记录";
    topLabel.font = UWFont(18);
    [self.view addSubview:topLabel];
    
    UIView *backTabView = [[UIView alloc]init];
    backTabView.backgroundColor = [UIColor whiteColor];
    backTabView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    backTabView.layer.shadowOffset = CGSizeMake(0, 1);
    backTabView.layer.shadowOpacity = 0.5;
    [self.view addSubview:backTabView];
    
    [backTabView addSubview:self.payBtn];
    [backTabView addSubview:self.transferBtn];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(balanceView.mas_bottom).with.offset(75);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-SafeBottomMargin - 52.0f);
    }];
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(kMargin);
        make.bottom.equalTo(self.tableView.mas_top).with.offset(-10);
    }];
    
    [backTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(SafeBottomMargin + 50.0f);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backTabView.mas_left).with.offset((kScreenWidth - 170*2 - 5)/2);
        make.top.equalTo(backTabView.mas_top).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(170, 40));
    }];
    [self.transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backTabView.mas_right).with.offset(-(kScreenWidth - 170*2 - 5)/2);
        make.top.equalTo(backTabView.mas_top).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(170, 40));
    }];


}

#pragma mark - Data
//RefreshData
- (void)p_getData{
    
    
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
    TransactionHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    
    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
        [_tableView registerClass:[TransactionHistoryCell class] forCellReuseIdentifier:@"cell"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self p_getData];
        }];
        [self.view addSubview:self.tableView];
    }return _tableView;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitle:@"收款" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor colorWithHexString:@"#0061FF"] forState:UIControlStateNormal];
        _payBtn.layer.borderWidth = 1;
        _payBtn.layer.borderColor = [UIColor colorWithHexString:@"#0061FF"].CGColor;
        [[_payBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            UWLog(@"click paybutton");
        }];
        
    }return _payBtn;
}

- (UIButton *)transferBtn{
    if (!_transferBtn) {
        _transferBtn = [[UIButton alloc]init];
        [_transferBtn setTitle:@"转账" forState:UIControlStateNormal];
        [_transferBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _transferBtn.backgroundColor = [UchainUtil mainThemeColor];
        [_transferBtn.layer addSublayer:[CAGradientLayer setGradualChangingColor:_transferBtn fromColor:@"#0061FF" toColor:@"#00B3FF"]];
        [[_transferBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            UWLog(@"click paybutton");
        }];
        
    }return _transferBtn;
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
