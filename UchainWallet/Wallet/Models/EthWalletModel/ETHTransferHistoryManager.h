//
//  ETHTransferHistoryManager.h
//  Apex
//
//  Created by yulin chi on 2018/8/15.
//  Copyright © 2018年 Gary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApexTransHistoryProtocal.h"

@interface ETHTransferHistoryManager : NSObject<ApexTransHistoryProtocal>

+ (instancetype)shareManager;

@end
