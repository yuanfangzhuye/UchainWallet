//
//  UchainPrepareBackUpController.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UchainPrepareBackUpController : UIViewController

@property (nonatomic, strong) ApexWalletModel *model;
@property (nonatomic, copy) dispatch_block_t BackupCompleteBlock;
@property (nonatomic, assign) BOOL isFromCreat; /**<  */

@end

NS_ASSUME_NONNULL_END
