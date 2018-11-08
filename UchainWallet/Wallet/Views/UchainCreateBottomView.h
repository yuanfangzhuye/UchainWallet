//
//  UchainCreateBottomView.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CreateBottomViewDelegate <NSObject>

- (void)createWallet;

- (void)importWallet;

@end

@interface UchainCreateBottomView : UIView

@property (nonatomic, strong) UIButton *importButton;
@property (nonatomic, strong) UILabel *importLabel;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) UILabel *createLabel;

@property (nonatomic, strong) id <CreateBottomViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
