//
//  UchainCreateBottomView.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainCreateBottomView.h"

@implementation UchainCreateBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowOpacity = 0.5;
        
        [self addSubview:self.importButton];
        [self.importButton addSubview:self.importLabel];
        [self addSubview:self.createButton];
        [self.createButton addSubview:self.createLabel];
        
        CGFloat totalWidth = kScreenWidth - 30;
        
        [self.importButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(10.0f);
            make.top.equalTo(self).with.offset(5.0f);
            make.size.mas_equalTo(CGSizeMake(totalWidth / 3, 39.0f));
        }];
        
        [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-10.0f);
            make.top.equalTo(self).with.offset(5.0f);
            make.size.mas_equalTo(CGSizeMake(totalWidth * 2 / 3, 39.0f));
        }];
        
        [self.importLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [self.createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    
    return self;
}

- (UIButton *)importButton
{
    if (!_importButton) {
        _importButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _importButton.layer.borderColor = [UchainUtil mainThemeColor].CGColor;
        _importButton.layer.borderWidth = 1.0f;
    }
    return _importButton;
}

- (UILabel *)importLabel
{
    if (!_importLabel) {
        _importLabel = [[UILabel alloc] init];
        _importLabel.font = [UIFont systemFontOfSize:15];
        _importLabel.textColor = [UchainUtil mainThemeColor];
        _importLabel.textAlignment = NSTextAlignmentCenter;
        _importLabel.text = SOLocalizedStringFromTable(@"导入钱包", nil);
    }
    
    return _importLabel;
}

- (UIButton *)createButton
{
    if (!_createButton) {
        _createButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _createButton.backgroundColor = [UchainUtil mainThemeColor];
    }
    return _createButton;
}

- (UILabel *)createLabel
{
    if (!_createLabel) {
        _createLabel = [[UILabel alloc] init];
        _createLabel.font = [UIFont systemFontOfSize:15];
        _createLabel.textColor = [UIColor whiteColor];
        _createLabel.textAlignment = NSTextAlignmentCenter;
        _createLabel.text = SOLocalizedStringFromTable(@"确认", nil);
    }
    
    return _createLabel;
}

@end
