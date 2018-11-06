//
//  UchainWalletModel.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UchainWalletModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSMutableArray *assetArr;
@property (nonatomic, strong) NSNumber *createTimeStamp;
@property (nonatomic, assign) BOOL isBackUp;

@property (nonatomic, assign) BOOL canTransfer; /**< 钱包是否可以交易 */

@end

NS_ASSUME_NONNULL_END
