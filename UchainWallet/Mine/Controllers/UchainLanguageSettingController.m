//
//  UchainLanguageSettingController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainLanguageSettingController.h"
#import "UchainLanguageSettingCell.h"

@interface UchainLanguageSettingController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *navigationBarTitle;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation UchainLanguageSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMainUI];
    [self initNavigationBar];
}

- (void)initMainUI
{
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UchainLanguageSettingCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset([UchainUtil naviBarHeight]);
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (void)initNavigationBar
{
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveBtn];
    self.navigationItem.titleView = self.navigationBarTitle;
}

#pragma mark - ------delegate & datasource------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UchainLanguageSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"简体中文";
        cell.languageSwitch.on = [[SOLocalization sharedLocalization].region isEqualToString:SOLocalizationSimplifiedChinese];
        [cell.languageSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"English";
        cell.languageSwitch.on = [[SOLocalization sharedLocalization].region isEqualToString:SOLocalizationEnglish];
        [cell.languageSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    
    return cell;
}

- (UISwitch *)getChineseSwitch
{
    UchainLanguageSettingCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return [cell.contentView viewWithTag:66];
}

- (UISwitch *)getEnglishSwitch
{
    UchainLanguageSettingCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    return [cell.contentView viewWithTag:66];
}

#pragma mark ------ private

- (void)switchChange:(id)sender
{
//    UISwitch *zhSwitch = [self getChineseSwitch];
//    UISwitch *enSwitch = [self getEnglishSwitch];
//    
//    NSLog(@"%ld, %ld", zhSwitch.on, enSwitch.on);
//    [zhSwitch setOn:!zhSwitch.on];
//    [enSwitch setOn:!enSwitch.on];
    
    NSString *str = [[SOLocalization sharedLocalization].region isEqualToString:SOLocalizationEnglish] ? SOLocalizationSimplifiedChinese : SOLocalizationEnglish;
    
    [self changeCurrentLanguageWith:str];
}

- (void)changeCurrentLanguageWith:(NSString *)language
{
    [SOLocalization sharedLocalization].region = language;
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:KLanguageSetting];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self showHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
        [UchainUtil jumpToMainController:self];
    });
}

#pragma mark - ------getter & setter------
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return _tableView;
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_saveBtn setTitle:SOLocalizedStringFromTable(@"Save", nil) forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _saveBtn;
}

- (UILabel *)navigationBarTitle
{
    if (!_navigationBarTitle) {
        _navigationBarTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        _navigationBarTitle.text = SOLocalizedStringFromTable(@"LanguageSetting", nil);
        _navigationBarTitle.textAlignment = NSTextAlignmentCenter;
        _navigationBarTitle.textColor = [UIColor blackColor];
    }
    return _navigationBarTitle;
}

@end
