//
//  UchainNewsViewModel.h
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UchainNewsViewModel : NSObject

@property (nonatomic,strong,readonly) RACCommand *tableCommand;

@end

NS_ASSUME_NONNULL_END
