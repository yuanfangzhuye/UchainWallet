//
//  ApexBlockChainManager.h
//  Apex
//
//  Created by chinapex on 2018/5/28.
//  Copyright © 2018年 Chinapex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApexBlockChainManager : NSObject

+ (instancetype)shareSharedManager;

@property (nonatomic, assign) NSInteger maxBlockChain; /**< 区块最高index */
@property (nonatomic, strong) NSMutableArray *seedsArr; /**< 节点seeds数组 */

- (void)prepare;
@end
