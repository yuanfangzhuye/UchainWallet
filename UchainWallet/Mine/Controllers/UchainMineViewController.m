//
//  UchainMineViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainMineViewController.h"
#import "UchainLanguageSettingController.h"
#import "JXLayoutButton.h"
#import "AboutUsViewController.h"
static CGFloat kMargin = 15;

@interface UchainMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) JXLayoutButton *managementWalletBtn;

@property (nonatomic, strong) JXLayoutButton *transactionRecordBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *cellTitleArray;
@property (nonatomic, copy) NSArray *cellImageNameArray;

@end

@implementation UchainMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellTitleArray = @[SOLocalizedStringFromTable(@"LanguageSetting", nil),SOLocalizedStringFromTable(@"Manual", nil),SOLocalizedStringFromTable(@"AboutUS", nil)];
    self.cellImageNameArray = @[@"mine-settings",@"mine-box",@"mail-opened"];
    
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

#pragma mark - ClickEvent
/*
 * 管理钱包
 */
- (void)p_managementWalletAction:(UIButton *)button{
    UWLog(@"ManagementWalletClick");
}

/*
 * 交易记录
 */
- (void)p_transactionRecordAction:(UIButton *)button{
    UWLog(@"TransactionRecordClick");
}




#pragma mark - UI
- (void)creatUI{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.backgroundImageView];

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor colorWithHexString:@"#FF00C1FF"];
    titleLabel.text = SOLocalizedStringFromTable(@"MyAccount", nil);
    [self.view addSubview:titleLabel];
    
    UIImageView *topImageView = [[UIImageView alloc]init];
    topImageView.image = [UIImage imageNamed:@"mine-topimage"];
    topImageView.layer.contentsGravity = @"resizeAspect";
    [self.view addSubview:topImageView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#FFC1C9CF"];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(92 + StatusBarHeight);
    }];
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(titleLabel.mas_top).with.offset(-5);
    }];

    [self.managementWalletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineView);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(lineView.mas_right);
    }];
    
    [self.transactionRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineView);
        make.left.equalTo(lineView.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    
    self.tableView.frame = CGRectMake(0, 256 + StatusBarHeight, kScreenWidth, 44 * 3 + 0.3);
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = SOLocalizedStringFromTable(@"MoreOption", nil);
    tipLabel.font = UWFont(16);
    tipLabel.textColor = [UIColor colorWithHexString:@"#FF00C1FF"];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView.mas_top).with.offset(- 13.5);
        make.left.equalTo(self.view.mas_left).with.offset(kMargin);
    }];

}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"idefienter";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.separatorInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    cell.textLabel.text = self.cellTitleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.cellImageNameArray[indexPath.row]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            {
                UchainLanguageSettingController *languageSettingController = [[UchainLanguageSettingController alloc] init];
                [self.navigationController pushViewController:languageSettingController animated:YES];
            }
            break;
            
        case 1:
            {
                
            }
            break;
            
        case 2:
            {
                AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
                [self.navigationController pushViewController:aboutUsVC animated:YES];
            }
            break;
            
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *cellLine = [[UIView alloc]init];
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(kMargin, 0, kScreenWidth - 2*kMargin, 0.3);
    lineLayer.backgroundColor = [UIColor colorWithHexString:@"#FFFFFFFF"].CGColor;
    [cellLine.layer addSublayer:lineLayer];
    return cellLine;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.3;
}

#pragma mark - getter

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]init];
        _backgroundImageView.image = [UIImage imageNamed:@"mine-backImage"];
    }
    
    return _backgroundImageView;
}

- (JXLayoutButton *)managementWalletBtn{
    if (!_managementWalletBtn) {
        _managementWalletBtn = [[JXLayoutButton alloc]init];
        _managementWalletBtn.layoutStyle = JXLayoutButtonStyleLeftImageRightTitle;
        [_managementWalletBtn setImage:[UIImage imageNamed:@"mine-pantone"] forState:UIControlStateNormal];
        _managementWalletBtn.titleLabel.font = UWFont(15);
        [_managementWalletBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_managementWalletBtn setTitle:SOLocalizedStringFromTable(@"ManagemetWallet", nil) forState:UIControlStateNormal];
        [_managementWalletBtn addTarget:self action:@selector(p_managementWalletAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_managementWalletBtn];
    }return _managementWalletBtn;
}

- (JXLayoutButton *)transactionRecordBtn{
    if (!_transactionRecordBtn) {
        _transactionRecordBtn = [[JXLayoutButton alloc]init];
        _transactionRecordBtn.layoutStyle = JXLayoutButtonStyleLeftImageRightTitle;
        [_transactionRecordBtn setImage:[UIImage imageNamed:@"mine-selected-file"] forState:UIControlStateNormal];
        _transactionRecordBtn.titleLabel.font = UWFont(15);
        [_transactionRecordBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_transactionRecordBtn setTitle:SOLocalizedStringFromTable(@"TransactionRecord", nil) forState:UIControlStateNormal];
        [_transactionRecordBtn addTarget:self action:@selector(p_transactionRecordAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_transactionRecordBtn];
    }return _transactionRecordBtn;

}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        [self.view addSubview:self.tableView];
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
