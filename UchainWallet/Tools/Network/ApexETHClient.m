//
//  ApexETHClient.m
//  Apex
//
//  Created by yulin chi on 2018/8/10.
//  Copyright © 2018年 Gary. All rights reserved.
//

#import "ApexETHClient.h"
#import <AFJSONRPCClient.h>
#import "ApexNetWorkCommonConfig.h"

@interface ApexETHClient()
@property (nonatomic, strong) AFJSONRPCClient *client;
@end

@implementation ApexETHClient

+ (instancetype)shareRPCClient
{
    static ApexETHClient *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

#pragma mark - private
- (void)invokeMethod:(NSString *)method
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [self.client invokeMethod:method success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

- (void)invokeMethod:(NSString *)method
      withParameters:(id)parameters
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [self.client invokeMethod:method withParameters:parameters requestId:@1 success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

#pragma mark - setter getter
- (AFJSONRPCClient *)client{
    if (!_client) {
        NSString *baseUrl = [ApexNetWorkCommonConfig getETHBaseUrl];
        NSLog(@"eth cli baseurl: %@",baseUrl);
        _client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:baseUrl]];
        _client.requestSerializer = [AFJSONRequestSerializer serializer];
        [_client.requestSerializer setValue:@"Basic d2FsbEBDUFg6Q0BwIyowMQ==" forHTTPHeaderField:@"Authorization"];
        AFSecurityPolicy *sp = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        sp.allowInvalidCertificates = YES;
        sp.validatesDomainName = NO;
        _client.securityPolicy = sp;
    }
    return _client;
}
@end
