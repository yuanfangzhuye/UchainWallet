//
//  UchainPrivacyAgreeFooterView.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainPrivacyAgreeFooterView.h"

@implementation UchainPrivacyAgreeFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.privacyAgreeBtn];
        [self.contentView addSubview:self.privacyAgreeLable];
        
        [self.privacyAgreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(15.0f);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(20);
        }];
        
        [self.privacyAgreeLable  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.privacyAgreeBtn.mas_right).offset(15);
            make.centerY.equalTo(self.privacyAgreeBtn.mas_centerY);
        }];
    }
    return self;
}

- (UIButton *)privacyAgreeBtn
{
    if (!_privacyAgreeBtn) {
        _privacyAgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_privacyAgreeBtn setImage:[UIImage imageNamed:@"icon-agree-unselected"] forState:UIControlStateNormal];
        [_privacyAgreeBtn setImage:[UIImage imageNamed:@"icon-agree-selected"] forState:UIControlStateSelected];
        [_privacyAgreeBtn setEnlargeEdge:20];
        @weakify(self);
        [[_privacyAgreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.privacyAgreeBtn.selected = !self.privacyAgreeBtn.selected;
        }];
    }
    return _privacyAgreeBtn;
}

- (UILabel *)privacyAgreeLable
{
    if (!_privacyAgreeLable) {
        _privacyAgreeLable = [[UILabel alloc] init];
        _privacyAgreeLable.font = [UIFont systemFontOfSize:10];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:SOLocalizedStringFromTable(@"I agree to the Service and Privacy Policy", nil)];
        if ([[SOLocalization sharedLocalization].region isEqualToString:SOLocalizationEnglish]) {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(15, 26)];
        }else{
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(11, 7)];
        }
        _privacyAgreeLable.attributedText = str;
    }
    return _privacyAgreeLable;
}

@end
