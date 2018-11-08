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

#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define  MC_iPhoneX (kScreenWidth == 375 && kScreenHeight == 812 ? YES : NO)
#define  SafeBottomMargin (MC_iPhoneX ? 34.f : 0.f)
#define  StatusBarAndNavigationBarHeight (MC_iPhoneX ? 88.f : 64.f)
#define  StatusBarHeight      (MC_iPhoneX ? 44.f : 20.f)

/**
 字体大小
 
 @param size 大小
 @return 字体
 */
#define UWFont(size) [UIFont systemFontOfSize:size]

/*
 *打印日志处理
 */
#ifdef DEBUG
#define UWLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define UWLog(...)
#endif

#ifdef DEBUG
#define MYLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define MYLog(...)
#endif


#define KLanguageSetting @"KLanguageSetting"
#define KisFirstCreateWalletDone  @"KisFirstCreateWalletDone"


#endif /* UchainConstants_h */
