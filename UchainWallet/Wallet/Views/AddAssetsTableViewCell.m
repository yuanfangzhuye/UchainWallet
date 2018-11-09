//
//  AddAssetsTableViewCell.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "AddAssetsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface  AddAssetsTableViewCell ()

@property (nonatomic,strong) UIImageView *cellImageView;
@property (nonatomic,strong) UILabel *cellTitleLabel;
@property (nonatomic, strong) UIButton *indicatorButton;

@end
@implementation AddAssetsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }return self;
}

- (void)creatUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.cellImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.cellImageView];
    [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15.0f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
    }];
    
    self.cellTitleLabel = [[UILabel alloc]init];
    self.cellTitleLabel.font = UWFont(13);
    [self.contentView addSubview:self.cellTitleLabel];
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellImageView.mas_right).with.offset(10.0f);
        make.right.equalTo(self.contentView).with.offset(-80.0f);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    self.indicatorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.indicatorButton.titleLabel.font = [UIFont systemFontOfSize:11];
    self.indicatorButton.layer.cornerRadius = 4.0f;
    self.indicatorButton.layer.borderWidth = 1.0f;
    self.indicatorButton.clipsToBounds = YES;
    [self.contentView addSubview:self.indicatorButton];
    [self.indicatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15.0f);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(55.0f, 30.0f));
    }];
}

- (void)setIndicatorSelected:(BOOL)indicatorSelected
{
    _indicatorSelected = indicatorSelected;
    if (_indicatorSelected) {
        [self.indicatorButton setTitleColor:[UIColor colorWithHexString:@"FFC800"] forState:UIControlStateNormal];
        [self.indicatorButton setTitle:SOLocalizedStringFromTable(@"移除", nil) forState:UIControlStateNormal];
        [self.indicatorButton.layer setBorderColor:[UIColor colorWithHexString:@"FFC800"].CGColor];
    }
    else {
        [self.indicatorButton.layer setBorderColor:[UIColor colorWithHexString:@"202AFF"].CGColor];
        [self.indicatorButton setTitleColor:[UIColor colorWithHexString:@"202AFF"] forState:UIControlStateNormal];
        [self.indicatorButton setTitle:SOLocalizedStringFromTable(@"添加", nil) forState:UIControlStateNormal];
    }
}

- (void)setModel:(ApexAssetModel *)model{
    _model = model;
    
    self.cellTitleLabel.text = model.symbol;
    
    NSURL *url = [NSURL URLWithString:model.image_url];
    if (model.image_url.length > 4 && url) {
        [self.cellImageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (!image) {
                self.cellImageView.image = [UIImage imageNamed:@"acountwallet-cell-icon"];
            }
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
