//
//  UchainWelcomePageViewController.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/6.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnWelcomePageBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface UchainWelcomePageViewController : UIViewController

@property (nonatomic, strong) ReturnWelcomePageBlock returnWelcomePageBlock;

- (void)returnWelcomePageBlock:(ReturnWelcomePageBlock)block;

@property (nonatomic, strong) RACSubject *didFinishScrollerWelcomeSub;
- (instancetype)initWithWelcomeController;

@end

NS_ASSUME_NONNULL_END
