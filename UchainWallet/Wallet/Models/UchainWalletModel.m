//
//  UchainWalletModel.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainWalletModel.h"

@implementation UchainWalletModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.isBackUp = ((NSNumber*)[aDecoder decodeObjectForKey:@"isBackUp"]).boolValue;
        self.assetArr = [aDecoder decodeObjectForKey:@"assetArr"];
        self.createTimeStamp = [aDecoder decodeObjectForKey:@"createTimeStamp"];
        self.canTransfer = ((NSNumber*)[aDecoder decodeObjectForKey:@"canTransfer"]).boolValue;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:@(self.isBackUp) forKey:@"isBackUp"];
    [aCoder encodeObject:self.assetArr forKey:@"assetArr"];
    [aCoder encodeObject:self.createTimeStamp forKey:@"createTimeStamp"];
    [aCoder encodeObject:@(self.canTransfer) forKey:@"canTransfer"];
}

@end
