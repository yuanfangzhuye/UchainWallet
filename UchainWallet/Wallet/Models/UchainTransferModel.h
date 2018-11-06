//
//  UchainTransferModel.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>

/**< 钱包交易状态 */
typedef NS_ENUM(NSInteger, UchainTransferStatus) {
    UchainTransferStatus_Blocking = 109871, /**< 打包中 */
    UchainTransferStatus_Progressing,     /**< 确认中 */
    UchainTransferStatus_Confirmed,       /**< 交易成功 */
    UchainTransferStatus_Failed,           /**< 交易失败 */
    UchainTransferStatus_Error
};

NS_ASSUME_NONNULL_BEGIN

@interface UchainTransferModel : NSObject

@property (nonatomic, assign) UchainTransferStatus status; /**< 此笔交易的状态 */
@property (nonatomic, strong) NSString *nonce; /**< eth特有 暂时未写入数据库 */

@property (nonatomic, strong) NSString *gas_consumed; //花费的gas数
@property (nonatomic, strong) NSString *vmstate; /**< 交易成功还是失败  失败的含有FAULT字段 */
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *decimal;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *assetId;

//新加字段
@property (nonatomic, assign) NSString *block_number; /**< 此笔交易所在的区块高度 */
@property (nonatomic, strong) NSString *gas_price; /**< gas单价*/
@property (nonatomic, strong) NSString *gas_fee; /**< 矿工fee */

@end

NS_ASSUME_NONNULL_END
