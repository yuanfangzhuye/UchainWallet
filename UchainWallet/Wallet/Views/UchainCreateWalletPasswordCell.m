//
//  UchainCreateWalletPasswordCell.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainCreateWalletPasswordCell.h"

@interface UchainCreateWalletPasswordCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation UchainCreateWalletPasswordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(15.0);
            make.right.equalTo(self.contentView).with.offset(-15.0f);
            make.top.equalTo(self.contentView).with.offset(10.0f);
            make.height.mas_equalTo(20.0f);
        }];
        
        _passwordTextField = [[ApexAlertTextField alloc] initWithFrame:CGRectZero];
        _passwordTextField.placeholder = SOLocalizedStringFromTable(@"Please input", nil);
        _passwordTextField.font = [UIFont systemFontOfSize:12];
        _passwordTextField.floatingLabelYPadding = 5;
        
        _passwordTextField.floatingLabelTextColor = [UIColor colorWithHexString:@"555555"];
        _passwordTextField.floatingLabelActiveTextColor = [UchainUtil mainThemeColor];
        
        _passwordTextField.keepBaseline = YES;
        _passwordTextField.isHiddenBottomLine = NO;
        _passwordTextField.secureTextEntry = NO;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _passwordTextField.alertString = SOLocalizedStringFromTable(@"Please input 8-16 characters", nil);
        _passwordTextField.alertShowConditionBlock = ^BOOL(NSString *text) {
            
            if (text.length > 0) {
                return false;
            }
            return true;
        };
        
        [self.contentView addSubview:_passwordTextField];
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10.0f);
            make.height.mas_equalTo(40.0f);
        }];
        
        _repeteTextField = [[ApexAlertTextField alloc] initWithFrame:CGRectZero];
        _repeteTextField.placeholder = SOLocalizedStringFromTable(@"Repeat password", nil);
        _repeteTextField.font = [UIFont systemFontOfSize:12];
        _repeteTextField.floatingLabelYPadding = 5;
        
        _repeteTextField.floatingLabelTextColor = [UIColor colorWithHexString:@"555555"];
        _repeteTextField.floatingLabelActiveTextColor = [UchainUtil mainThemeColor];
        
        _repeteTextField.keepBaseline = YES;
        _repeteTextField.isHiddenBottomLine = NO;
        _repeteTextField.secureTextEntry = NO;
        _repeteTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _repeteTextField.alertString = SOLocalizedStringFromTable(@"Please input 8-16 characters", nil);
        _repeteTextField.alertShowConditionBlock = ^BOOL(NSString *text) {
            
            if (text.length > 0) {
                return false;
            }
            return true;
        };
        
        [self.contentView addSubview:_repeteTextField];
        [_repeteTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.top.equalTo(_passwordTextField.mas_bottom).with.offset(10.0f);
            make.height.mas_equalTo(40.0f);
        }];
    }
    
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = SOLocalizedStringFromTable(@"Login Password", nil);
    }
    
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
