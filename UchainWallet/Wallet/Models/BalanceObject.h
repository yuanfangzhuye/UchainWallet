//
//  BalanceObject.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UchainAssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BalanceObject : NSObject<NSCoding>
@property (nonatomic, strong) NSString *asset;
@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) NSString *gas; /**< eth*/

//查找相关的assetmodel
//- (UchainAssetModel*)getRelativeETHAssetModel;
//- (BOOL)isHashEqual:(id)objct;
@end

NS_ASSUME_NONNULL_END
