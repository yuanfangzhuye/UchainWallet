//
//  TransactionHistoryCell.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/9.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "TransactionHistoryCell.h"

static CGFloat kCellMargin = 15;

@interface TransactionHistoryCell()

@property (nonatomic,strong) UILabel *cellTitleLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *balanceLabel;

@end

@implementation TransactionHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_createUI];
    }return self;
}

- (void)p_createUI{
    
    self.balanceLabel = [[UILabel alloc]init];
    self.balanceLabel.font = UWFont(18);
    self.balanceLabel.text = @"+40000.0000 ETH";
    self.balanceLabel.textColor = [UIColor colorWithHexString:@"#FB001F"];
    [self.contentView addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-kCellMargin);
        make.centerY.equalTo(self.contentView);
    }];

    
    self.cellTitleLabel = [[UILabel alloc]init];
    self.cellTitleLabel.numberOfLines = 0;
    self.cellTitleLabel.font = UWFont(15);
    self.cellTitleLabel.text = @"2018047USDSP001AP…";
    [self.contentView addSubview:self.cellTitleLabel];
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(kCellMargin);
        make.top.equalTo(self.contentView.mas_top).with.offset(kCellMargin);
        make.right.equalTo(self.balanceLabel.mas_left).with.offset(-kCellMargin);
    }];
    
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.font = UWFont(12);
    self.dateLabel.text = @"2018-02-25";
    self.dateLabel.textColor = [UIColor colorWithHexString:@"#FF9DACB6"];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(kCellMargin);
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
