//
//  UchainSideViewController.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/1.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UchainSideViewController : UIViewController

@property (nonatomic, strong) RACSubject *didChangeTypeSub;

@end

NS_ASSUME_NONNULL_END
