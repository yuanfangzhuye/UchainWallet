//
//  UchainCreateWalletTipsHeaderView.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainCreateWalletTipsHeaderView.h"

@interface UchainCreateWalletTipsHeaderView ()

@property (nonatomic, strong) UIView *backShadowView;
@property (nonatomic, strong) UILabel *tipTopLabel;
@property (nonatomic, strong) UILabel *tipBottomLabel;

@end

@implementation UchainCreateWalletTipsHeaderView

+(CGFloat)getTipsContentHeight
{
    CGFloat tips01Height = [UchainUtil calculateTextHeight:[UIFont systemFontOfSize:13] givenText:SOLocalizedStringFromTable(@"CreatWalletTip01", nil) givenWidth:kScreenWidth - 70.0f];
    CGFloat tips02Height = [UchainUtil calculateTextHeight:[UIFont systemFontOfSize:13] givenText:SOLocalizedStringFromTable(@"CreatWalletTip02", nil) givenWidth:kScreenWidth - 70.0f];
    
    return 15.0f * 2 + tips01Height + 10.0f + tips02Height;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.backShadowView];
        [self.backShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        CGFloat tips01Height = [UchainUtil calculateTextHeight:[UIFont systemFontOfSize:13] givenText:SOLocalizedStringFromTable(@"CreatWalletTip01", nil) givenWidth:kScreenWidth - 70.0f];
        CGFloat tips02Height = [UchainUtil calculateTextHeight:[UIFont systemFontOfSize:13] givenText:SOLocalizedStringFromTable(@"CreatWalletTip02", nil) givenWidth:kScreenWidth - 70.0f];
        
        UIImageView *topIconImageView = [[UIImageView alloc] init];
        topIconImageView.backgroundColor = [UIColor blueColor];
        topIconImageView.layer.cornerRadius = 2.0f;
        topIconImageView.clipsToBounds = YES;
        [self.contentView addSubview:topIconImageView];
        [topIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backShadowView).with.offset(15.0f);
            make.top.equalTo(self.backShadowView).with.offset(20.0f);
            make.size.mas_equalTo(CGSizeMake(10.0f, 10.0f));
        }];
        
        [self.backShadowView addSubview:self.tipTopLabel];
        [self.tipTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backShadowView).with.offset(30.0f);
            make.right.equalTo(self.backShadowView).with.offset(-10.0f);
            make.top.equalTo(self.backShadowView).with.offset(15.0f);
            make.height.mas_equalTo(tips01Height);
        }];
        
        UIImageView *bottomIconImageView = [[UIImageView alloc] init];
        bottomIconImageView.backgroundColor = [UchainUtil mainThemeColor];
        bottomIconImageView.layer.cornerRadius = 2.0f;
        bottomIconImageView.clipsToBounds = YES;
        [self.contentView addSubview:bottomIconImageView];
        [bottomIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backShadowView).with.offset(15.0f);
            make.top.equalTo(self.tipTopLabel.mas_bottom).with.offset(15.0f);
            make.size.mas_equalTo(CGSizeMake(10.0f, 10.0f));
        }];
        
        [self.backShadowView addSubview:self.tipBottomLabel];
        [self.tipBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backShadowView).with.offset(30.0f);
            make.right.equalTo(self.backShadowView).with.offset(-10.0f);
            make.top.equalTo(self.tipTopLabel.mas_bottom).with.offset(10.0f);
            make.height.mas_equalTo(tips02Height);
        }];
    }
    
    return self;
}

- (UIView *)backShadowView
{
    if (!_backShadowView) {
        _backShadowView = [[UIView alloc] init];
        _backShadowView.backgroundColor = [UIColor whiteColor];
        _backShadowView.layer.cornerRadius = 4.0f;
        _backShadowView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        _backShadowView.layer.shadowOffset = CGSizeMake(1, 1);
        _backShadowView.layer.shadowOpacity = 0.3;
    }
    
    return _backShadowView;
}

- (UILabel *)tipTopLabel
{
    if (!_tipTopLabel) {
        _tipTopLabel = [[UILabel alloc] init];
        _tipTopLabel.text = SOLocalizedStringFromTable(@"CreatWalletTip01", nil);
        _tipTopLabel.font = [UIFont systemFontOfSize:13];
        _tipTopLabel.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1];
        _tipTopLabel.numberOfLines = 0;
    }
    return _tipTopLabel;
}

- (UILabel *)tipBottomLabel
{
    if (!_tipBottomLabel) {
        _tipBottomLabel = [[UILabel alloc] init];
        _tipBottomLabel.text = SOLocalizedStringFromTable(@"CreatWalletTip02", nil);
        _tipBottomLabel.font = [UIFont systemFontOfSize:13];
        _tipBottomLabel.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1];
        _tipBottomLabel.numberOfLines = 0;
    }
    return _tipBottomLabel;
}

@end
