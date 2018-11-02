//
//  UchainMethodSwizzlingUtil.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/2.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UchainMethodSwizzlingUtil : NSObject

+ (void)methodSwizzle:(Class)clazz origin:(SEL)originSel new:(SEL)newSel;
+ (void)methodSwizzle:(Class)clazz otherClass:(Class)otherClass origin:(SEL)originSel new:(SEL)newSel;

@end

NS_ASSUME_NONNULL_END
