//
//  UchainMethodSwizzlingUtil.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/2.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainMethodSwizzlingUtil.h"
#import <objc/runtime.h>

@implementation UchainMethodSwizzlingUtil

+(void)methodSwizzle:(Class)clazz origin:(SEL)originSel new:(SEL)newSel {
    Method originalMethod =
    class_getInstanceMethod(clazz, originSel);
    Method swizzledMethod =
    class_getInstanceMethod(clazz, newSel);
    
    BOOL isAddSuccess =
    class_addMethod(clazz, originSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (isAddSuccess) {
        class_replaceMethod(clazz, newSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)methodSwizzle:(Class)clazz otherClass:(Class)otherClass origin:(SEL)originSel new:(SEL)newSel{
    Method originalMethod =
    class_getInstanceMethod(clazz, originSel);
    Method swizzledMethod =
    class_getInstanceMethod(otherClass, newSel);
    
    BOOL isAddSuccess =
    class_addMethod(clazz, originSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (isAddSuccess) {
        class_replaceMethod(clazz, newSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
