//
//  UchainWalletTableViewCell.h
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UchainWalletTableViewCell : UITableViewCell

@property (weak, nonatomic) NSString *walletName;
@property (weak, nonatomic) NSString *backupWallet;

@end

NS_ASSUME_NONNULL_END
