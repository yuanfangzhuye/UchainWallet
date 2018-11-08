//
//  UchainPrivacyAgreeFooterView.h
//  UchainWallet
//
//  Created by 李超 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol  PrivacyAgreeDelegate <NSObject>
//
//- (void)goToHtmlWithString:(NSString *)htmlString;
//
//@end

@interface UchainPrivacyAgreeFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton *privacyAgreeBtn;
@property (nonatomic, strong) UILabel *privacyAgreeLable;

//@property (nonatomic, strong) id <PrivacyAgreeDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
