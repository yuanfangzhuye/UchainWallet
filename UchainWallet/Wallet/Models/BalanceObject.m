//
//  BalanceObject.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "BalanceObject.h"

@implementation BalanceObject
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.asset = [aDecoder decodeObjectForKey:@"asset"];
        self.value = [aDecoder decodeObjectForKey:@"value"];
        self.gas = [aDecoder decodeObjectForKey:@"gas"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.asset forKey:@"asset"];
    [aCoder encodeObject:self.value forKey:@"value"];
    [aCoder encodeObject:self.gas forKey:@"gas"];
}

- (BOOL)isHashEqual:(id)objct{
    return self == objct;
}

- (BOOL)isEqual:(id)object{
    if (![object isKindOfClass:BalanceObject.class]) {
        return false;
    }
    
    typeof(self) balanceObj = object;
    return [balanceObj.asset isEqualToString:self.asset];
}

//- (UchainAssetModel *)getRelativeETHAssetModel{
//    UchainAssetModel *model = nil;
//    for (UchainAssetModel *asModel in [ETHAssetModelManage getLocalAssetModelsArr]) {
//        if ([asModel.hex_hash isEqualToString:self.asset]) {
//            model = asModel;
//        }
//    }
//
//    return model;
//}

@end
