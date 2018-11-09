//
//  WalletBalanceView.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/9.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "WalletBalanceView.h"
#import "CAGradientLayer+UWGradient.h"

@interface WalletBalanceView()
@end

@implementation WalletBalanceView
- (instancetype)initWithFrame:(CGRect)frame withTypeName:(NSString *)type withBalance:(NSString *)balance
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_createUI];
    }
    return self;
}

- (void)p_createUI{
    [self.layer addSublayer:[CAGradientLayer setGradualChangingColor:self fromColor:@"#0061FF" toColor:@"#00B3FF"]];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.shadowColor = [UIColor colorWithHexString:@"#003C7F"].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 10;
    
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.font = UWFont(15);
    typeLabel.textColor = [UIColor whiteColor];
    [self addSubview:typeLabel];
    self.typeLabel = typeLabel;
    
    UILabel *balanceLabel = [[UILabel alloc]init];
    balanceLabel.font = UWFont(30);
    balanceLabel.textColor = [UIColor whiteColor];
    [self addSubview:balanceLabel];
    self.balanceLabel = balanceLabel;
    
}

- (void)layoutSubviews{
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(25);
    }];
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.typeLabel.mas_bottom).with.offset(10);
    }];

}


@end
