//
//  UchainWalletTableViewCell.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainWalletTableViewCell.h"
static CGFloat kCellMargin = 15;
@interface UchainWalletTableViewCell()

@property (nonatomic,strong) UIImageView *cellImageView;
@property (nonatomic,strong) UILabel *cellTitleLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;

@end
@implementation UchainWalletTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }return self;
}

- (void)creatUI{
    
    self.backgroundColor = [UIColor clearColor];
    CGFloat backLayerW = 38;
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = CGRectMake(backLayerW, kCellMargin, kScreenWidth - backLayerW - kCellMargin, 60);
    backLayer.cornerRadius = 2;
    backLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:backLayer];
    int arcX = arc4random()%5 + 1;
    self.cellImageView = [[UIImageView alloc]init];
    self.cellImageView.layer.contentsGravity = @"resizeAspect";
    self.cellImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",arcX]];
    [self.contentView addSubview:self.cellImageView];
    [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_left).with.offset(backLayerW);
        make.centerY.equalTo(self.contentView.mas_top).with.offset(kCellMargin + 30);
    }];
    
    self.cellTitleLabel = [[UILabel alloc]init];
    self.cellTitleLabel.font = UWFont(15);
    self.cellTitleLabel.text = @"Oamul Lu的钱包";
    [self.contentView addSubview:self.cellTitleLabel];
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellImageView.mas_right).with.offset(kCellMargin);
        make.top.equalTo(self.contentView.mas_top).with.offset(kCellMargin*2);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kCellMargin);
    }];
    
    self.arrowImageView = [[UIImageView alloc]init];
    self.arrowImageView.layer.contentsGravity = @"resizeAspect";
    self.arrowImageView.image = [UIImage imageNamed:@"wallet-cell-arrow"];
    [self.contentView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-kCellMargin*2);
        make.top.equalTo(self.contentView.mas_top).with.offset(kCellMargin*2);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kCellMargin);
    }];
}

- (void)setWalletName:(NSString *)walletName
{
    self.cellTitleLabel.text = walletName;
}

- (void)setBackupWallet:(NSString *)backupWallet
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
