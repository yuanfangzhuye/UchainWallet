//
//  UchainAccountStateModel.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainAccountStateModel.h"

@implementation UchainAccountStateModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"balances" : [BalanceObject class]};
}
@end
