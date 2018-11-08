//
//  UchainCreateWalletPasswordCell.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UchainCreateWalletPasswordCell : UITableViewCell

@property (nonatomic, strong) ApexAlertTextField *passwordTextField;
@property (nonatomic, strong) ApexAlertTextField *repeteTextField;

@property (nonatomic, strong) RACSignal *combineSignal;

@end

NS_ASSUME_NONNULL_END
