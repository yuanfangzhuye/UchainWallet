//
//  UchainCreateWalletNameCell.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainCreateWalletNameCell.h"

@interface UchainCreateWalletNameCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation UchainCreateWalletNameCell

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
        
        _inputTextField = [[ApexAlertTextField alloc] initWithFrame:CGRectZero];
        _inputTextField.font = [UIFont systemFontOfSize:12];
        _inputTextField.floatingLabelYPadding = 5;
        _inputTextField.placeholder = SOLocalizedStringFromTable(@"Please input", nil);

        _inputTextField.floatingLabelTextColor = [UIColor colorWithHexString:@"555555"];
        _inputTextField.floatingLabelActiveTextColor = [UchainUtil mainThemeColor];

        _inputTextField.keepBaseline = YES;
        _inputTextField.isHiddenBottomLine = NO;
        _inputTextField.secureTextEntry = NO;
        _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

        _inputTextField.alertString = SOLocalizedStringFromTable(@"Please enter the correct wallet name", nil);
        _inputTextField.alertShowConditionBlock = ^BOOL(NSString *text) {

            if (text.length > 0) {
                return false;
            }
            return true;
        };
        
        [self.contentView addSubview:_inputTextField];
        [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10.0f);
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
        _titleLabel.text = SOLocalizedStringFromTable(@"Wallet Name", nil);
    }
    
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
