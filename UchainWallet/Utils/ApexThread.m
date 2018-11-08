//
//  ApexThread.m
//  Apex
//
//  Created by chinapex on 2018/5/31.
//  Copyright © 2018年 Gary. All rights reserved.
//

#import "ApexThread.h"

@interface ApexThread()
@property (nonatomic, copy) dispatch_block_t successBlock;
@end

@implementation ApexThread

+ (instancetype)shareInstance
{
    static ApexThread *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ApexThread alloc] init];
    });
    
    return manager;
}

- (void)startRunLoopSuccessBlock:(dispatch_block_t)block{
    ApexThread *thread = [[ApexThread alloc] initWithTarget:self selector:@selector(runLoopRun) object:nil];
    thread.name = @"pex runloop thred";
    self.successBlock = block;
    [thread start];
}

- (void)runLoopRun{
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    self.threadRunLoop = [NSRunLoop currentRunLoop];
    
    [self.threadRunLoop addTimer:[NSTimer timerWithTimeInterval:600 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"pex runloop running");
    }] forMode:NSDefaultRunLoopMode];
    
    if (self.successBlock) {
        self.successBlock();
    }
    
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"runloop run failed");
}
@end
