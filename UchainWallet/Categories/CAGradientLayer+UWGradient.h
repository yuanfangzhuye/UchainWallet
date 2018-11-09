//
//  CAGradientLayer+UWGradient.h
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/9.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAGradientLayer (UWGradient)
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
@end

NS_ASSUME_NONNULL_END
