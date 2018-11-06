//
//  UchainTransactionModel.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainTransactionModel.h"

@implementation UchainTransactionModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tx_hash" : @"hash",};
}

@end


@implementation UchainReceiptModel

@end
