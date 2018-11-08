//
//  UchainNewsViewModel.m
//  UchainWallet
//
//  Created by 马晨曦 on 2018/11/7.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainNewsViewModel.h"
#import "UchainNewModel.h"
@implementation UchainNewsViewModel
- (instancetype)init{
    if (self = [super init]) {
        [self initializeBind];
    }return self;
}

- (void)initializeBind{
    @weakify(self)
    _tableCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            UchainNewModel *newModel = [[UchainNewModel alloc]init];
            newModel.cellTitle = @"特斯拉私有化后怎么样？看看SpaceX就知道了?";
            newModel.cellDate = @"08-18";
            newModel.imageUrl = @"icon-wallet-selected";
            NSArray *arr =@[newModel];

            [subscriber sendNext:arr];
            [subscriber sendCompleted];
            
            return nil;
        }];
        return signal;
    }];
    
    
    
}
@end
