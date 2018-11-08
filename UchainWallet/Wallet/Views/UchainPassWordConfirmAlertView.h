//
//  UchainPassWordConfirmAlertView.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApexWalletManagerProtocal.h"

typedef void(^successBlock)(NeomobileWallet* wallet);

@interface UchainPassWordConfirmAlertView : NSObject

+ (void)showDeleteConfirmAlertAddress:(NSString*)address subTitle:(NSString*)subtitle Success:(successBlock)success fail:(dispatch_block_t)fail;

+ (void)showEntryPasswordAlertAddress:(NSString *)address walletManager:(id<ApexWalletManagerProtocal>)manager subTitle:(NSString*)subtitle Success:(successBlock)success fail:(dispatch_block_t)fail;

@end
