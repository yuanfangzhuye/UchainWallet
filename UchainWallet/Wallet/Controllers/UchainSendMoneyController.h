//
//  UchainSendMoneyController.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface UchainSendMoneyController : UIViewController

@property (nonatomic, strong) NSString *walletName;
@property (nonatomic, strong) NSString *walletAddress;
@property (nonatomic, strong) BalanceObject *balanceModel;
//@property (nonatomic, strong) id<ApexWalletManagerProtocal> walletManager; /**<  */
@property (nonatomic, strong) NSString *toAddressIfHave;
@property (nonatomic, strong) NSString *unit;

@end

NS_ASSUME_NONNULL_END
