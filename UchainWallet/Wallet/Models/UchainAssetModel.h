//
//  UchainAssetModel.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BalanceObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface UchainAssetModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *precision;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *hex_hash; /**< 0xassetId */

//- (BalanceObject*)convertToBalanceObject;

@end

NS_ASSUME_NONNULL_END
