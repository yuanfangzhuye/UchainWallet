//
//  WalletBalanceView.h
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/9.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletBalanceView : UIView

@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *balanceLabel;

- (instancetype)initWithFrame:(CGRect)frame withTypeName:(NSString *)type withBalance:(NSString *)balance;
@end

NS_ASSUME_NONNULL_END
