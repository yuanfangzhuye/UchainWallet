//
//  UchainLanguageSettingCell.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainLanguageSettingCell.h"

@implementation UchainLanguageSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _languageSwitch = [[UISwitch alloc] init];
    _languageSwitch.tag = 66;
    _languageSwitch.onTintColor = [UIColor blueColor];
    [self.contentView addSubview:_languageSwitch];
    [_languageSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(60.0f, 30.0f));
    }];
    _languageSwitch.on = NO;
    
    [self addLinecolor:[UIColor colorWithRed:240 / 255.0f green:240 / 255.0f blue:240 / 255.0f alpha:1.0f] edge:UIEdgeInsetsMake(-1, 15.0f, 0, 15.0f)];
}

@end
