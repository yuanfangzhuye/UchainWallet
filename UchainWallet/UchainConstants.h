//
//  UchainConstants.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#ifndef UchainConstants_h
#define UchainConstants_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScale [UIScreen mainScreen].scale
#define scaleWidth375(w) w/375.0 * kScreenWidth
#define scaleHeight667(h) h/667.0 * kScreenHeight

#define kWelcomePageNumber 2

#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})


#define KLanguageSetting @"KLanguageSetting"
#define KisFirstCreateWalletDone  @"KisFirstCreateWalletDone"


#endif /* UchainConstants_h */
