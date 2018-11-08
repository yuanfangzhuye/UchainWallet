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

#define assetId_CPX @"0x45d493a6f73fa5f404244a5fb8472fc014ca5885"
#define assetId_Neo @"0xc56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b"
#define assetId_NeoGas @"0x602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7"
#define assetId_Eth @"0x0000000000000000000000000000000000000000"

#define assetID_Test_Erc20 @"0xc7773e07adb2642a1eb03c5e340430b6cedc2aa9"

#define UserDefaultsIdentifier @"com.chinapex.apex"
#define isFirstOpenApp @"isFirstOpenApp"
#define commonScheme @"Apex://"
#define KEYCHAIN_KEY(address) [NSString stringWithFormat:@"%@", address]
#define LASTUPDATETXHISTORY_KEY(address) [NSString stringWithFormat:@"LASTUPDATETXHISTORY_KEY_%@", address]
#define TXRECORD_KEY @"TXRECORD_KEY"
#define KMyAseetArr @"KMyAseetArr"
#define KAssetModelListKey @"KAssetModelListKey"
#define KETHAssetModelListKey @"KETHAssetModelListKey"
#define KLanguageSetting @"KLanguageSetting"
#define KBindingWalletAddress @"KBindingWalletAddress"
#define KBindingAddressToCommonProfile [NSString stringWithFormat:@"address_commonProfile"]
#define KBindingAddressToSpecialProfile [NSString stringWithFormat:@"address_specialProfile"]
#define KisFirstCreateWalletDone  @"KisFirstCreateWalletDone"
#define KglobleWalletType @"KglobleWalletType" //全局的钱包类型key
#define KLocalTXTrackerKey @"KLocalTXTrackerKey" //本地交易状态跟踪key
#define KEthNonceTrackerKey @"KEthNonceTrackerKey" //本地存储的tx的nonce

//neo
#define baseUrl_tool_test @"http://tmp.chinapex.com.cn/wallets-java-version/tool/"
#define baseUrl_cli_test @"http://dev.chinapex.com.cn:10086/neo-cli/"

#define baseUrl_tool_main @"https://tracker.chinapex.com.cn/tool/jar-serv/"
#define baseUrl_cli_main @"https://tracker.chinapex.com.cn/neo-cli-2-9/"

//eth
#define ETH_baseUrl_cli_Main @"https://tracker.chinapex.com.cn/eth-parity-cli/" //parity

#define ETHApiKey @"CTTVCEUHGU1UMY14IMWH5G9IREY7AAMT1V"

#define neo_assetid @"0xc56f33fc6ecfcd0c225c4ab356fee59390af8560be0e930faebe74a6daff7c9b"
#define neoGas_Assetid @"0x602c79718b16e442de58778e148d0b1084e3b2dffd5de6b7b16cee7969282de7"

#define mnemonicEnglish @"en_US"
#define mnemonicChianese @"zh_CN"

#define EthType @"Eth"
#define Erc20Type @"Erc20"
#define NeoType @"NEO"

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
