//
//  UchainAccountListCell.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainAccountListCell.h"

static CGFloat kCellMargin = 15;

@interface UchainAccountListCell()

@property (nonatomic,strong) UIImageView *cellImageView;
@property (nonatomic,strong) UILabel *cellTitleLabel;
@property (nonatomic,strong) UILabel *balanceLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;

@end

@implementation UchainAccountListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }return self;
}

- (void)creatUI{
    
    self.backgroundColor = [UIColor clearColor];
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = CGRectMake(kCellMargin, kCellMargin, kScreenWidth - kCellMargin*2, 70);
    backLayer.cornerRadius = 2;
    backLayer.backgroundColor = [UIColor whiteColor].CGColor;
    backLayer.shadowColor = [UIColor colorWithHexString:@"#14000E5E"].CGColor;
    backLayer.opacity = 0.8f;
    backLayer.shadowOffset = CGSizeMake(0, 1);
    backLayer.shadowRadius = 15.f;
    [self.contentView.layer addSublayer:backLayer];
    
    self.cellImageView = [[UIImageView alloc]init];
    self.cellImageView.layer.contentsGravity = @"resizeAspect";
    self.cellImageView.image = [UIImage imageNamed:@"acountwallet-cell-icon"];
    [self.contentView addSubview:self.cellImageView];
    [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(kCellMargin*2);
        make.centerY.equalTo(self.contentView.mas_top).with.offset(kCellMargin + 35);
    }];
    
    self.cellTitleLabel = [[UILabel alloc]init];
    self.cellTitleLabel.font = UWFont(13);
    self.cellTitleLabel.text = @"ETH";
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
    
    self.balanceLabel = [[UILabel alloc]init];
    self.balanceLabel.font = [UIFont systemFontOfSize:15 weight:3];
    self.balanceLabel.text = @"0000.0";
    [self.contentView addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).with.offset(-kCellMargin);
        make.top.equalTo(self.contentView.mas_top).with.offset(kCellMargin*2);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kCellMargin);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
