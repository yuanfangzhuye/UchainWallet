//
//  AddAssetsTableViewCell.h
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddAssetsTableViewCell : UITableViewCell

@property (nonatomic, strong) ApexAssetModel *model;
@property (nonatomic, assign) BOOL indicatorSelected;

@end

NS_ASSUME_NONNULL_END
