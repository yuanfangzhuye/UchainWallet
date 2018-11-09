//
//  AddAssetsTableViewCell.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "AddAssetsTableViewCell.h"
static CGFloat kCellMargin = 15;
@interface  AddAssetsTableViewCell()

@property (nonatomic,strong) UIImageView *cellImageView;
@property (nonatomic,strong) UILabel *cellTitleLabel;

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
