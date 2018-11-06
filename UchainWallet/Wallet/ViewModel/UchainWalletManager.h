//
//  UchainWalletManager.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/5.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UchainAssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UchainWalletManager : NSObject

+ (instancetype)shareInstanceManager;

+ (void)creatETHWalletSuccess:(void (^)(EthmobileWallet *wallet))success failed:(void (^)(NSError *error))fail;

//发送交易
+ (void)sendTxWithWallet:(EthmobileWallet*)wallet to:(NSString*)to nonce:(NSString*)nonce amount:(NSString*)amount gas:(NSString*)gas
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**erc20 交易  原始金额不用乘以精度*/
+ (void)sendERC20TxWithWallet:(EthmobileWallet*)wallet contractAddress:(NSString*)contract to:(NSString*)to nonce:(NSString*)nonce amount:(NSString*)amount gas:(NSString*)gas assetModel:(UchainAssetModel*)assetModel
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//获取交易详情
+ (void)requestTransactionByHash:(NSString*)hash
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//获取nonce
+ (void)requestTransactionCount:(NSString*)address
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//获取交易收据,pending中的交易返回nil
/**
 交易上链后才会有返回
 */
+ (void)requestTransactionReceiptByHash:(NSString*)hash
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


//获取以太币资产
+ (void)requestETHBalanceOfAddress:(NSString *)address
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//获取当前块数
+ (void)requestCurrentBlockNumberSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//查询erc20资产
+ (void)requestERC20BalanceOfContract:(NSString*)contract Address:(NSString*)address decimal:(NSString*)decimal
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//获取当前的gas价格
+ (void)getCurrentGasPrice:(void (^)(NSString *gasPriceInWei))successBlock fail:(void (^)(NSError *error))failBlock;

@end

NS_ASSUME_NONNULL_END
