//
//  UchainAssetModel.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainAssetModel.h"

@implementation UchainAssetModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.symbol = [aDecoder decodeObjectForKey:@"symbol"];
        self.precision = [aDecoder decodeObjectForKey:@"precision"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.image_url = [aDecoder decodeObjectForKey:@"image_url"];
        self.hex_hash = [aDecoder decodeObjectForKey:@"hex_hash"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.symbol forKey:@"symbol"];
    [aCoder encodeObject:self.precision forKey:@"precision"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.image_url forKey:@"image_url"];
    [aCoder encodeObject:self.hex_hash forKey:@"hex_hash"];
}

- (BalanceObject *)convertToBalanceObject{
    BalanceObject *balanceObj = [[BalanceObject alloc] init];
    balanceObj.asset = self.hex_hash;
    balanceObj.value = @"0";
    return balanceObj;
}

@end
