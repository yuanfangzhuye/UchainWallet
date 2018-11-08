//
//  UchainNewsTableViewCell.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainNewsTableViewCell.h"
#import "UchainNewModel.h"

static CGFloat kCellMargin = 15;

@interface UchainNewsTableViewCell()
@property (nonatomic,strong) UILabel *cellTitleLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UIImageView *cellImageView;
@end

@implementation UchainNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }return self;
}

- (void)creatUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = CGRectMake(kCellMargin, 0, kScreenWidth - 2*kCellMargin, 110);
    backLayer.cornerRadius = 5;
    backLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:backLayer];
    
    self.cellImageView = [[UIImageView alloc]init];
    self.cellImageView.layer.contentsGravity = @"resizeAspect";
    [self.contentView addSubview:self.cellImageView];
    [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-kCellMargin);
        make.top.equalTo(self.contentView.mas_top).with.offset(kCellMargin);
        make.size.mas_equalTo(CGSizeMake(100, 80));
    }];
    
    self.cellTitleLabel = [[UILabel alloc]init];
    self.cellTitleLabel.numberOfLines = 0;
    self.cellTitleLabel.font = UWFont(17);
    [self.contentView addSubview:self.cellTitleLabel];
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(kCellMargin*2);
        make.top.equalTo(self.contentView.mas_top).with.offset(kCellMargin);
        make.right.equalTo(self.cellImageView.mas_left).with.offset(-kCellMargin);
    }];
    
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.font = UWFont(11);
    self.dateLabel.textColor = [UIColor colorWithHexString:@"#FF9DACB6"];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(kCellMargin*2);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kCellMargin*2);
    }];
}

- (void)setUchainNewModel:(UchainNewModel *)uchainNewModel{
    self.cellTitleLabel.text = uchainNewModel.cellTitle;
    self.dateLabel.text = uchainNewModel.cellDate;
    self.cellImageView.image = [UIImage imageNamed:uchainNewModel.imageUrl];
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
