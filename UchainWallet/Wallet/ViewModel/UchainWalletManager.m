//
//  UchainWalletManager.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainWalletManager.h"

@implementation UchainWalletManager

+ (instancetype)shareInstanceManager
{
    static UchainWalletManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

@end
