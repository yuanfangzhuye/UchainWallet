//
//  UchainAccountStateModel.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BalanceObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface UchainAccountStateModel : NSObject

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *script_hash;
@property (nonatomic, strong) NSNumber *frozen;
@property (nonatomic, strong) NSArray<BalanceObject *> *balances;

@end

NS_ASSUME_NONNULL_END
