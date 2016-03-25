//
//  RMNetServiceFoo1API.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "RMNetServiceFoo1API.h"

@implementation RMNetServiceFoo1API
- (instancetype)init {
    self = [super init];
    if (self) {
        self.config = self;
    }
    return self;
}

- (NSString *)requestURL
{
    return @"";
}

- (BOOL) isHTTPS
{
    return YES;
}

- (NSString *)baseURL
{
    return @"https://www.baidu.com";
}

- (NSDictionary *)tokenKeyAndValue
{
    return @{@"accessToken":@"0619eab0-d1d5-4d54-975e-d0cbe724a6c76c00fd02f0f9d791991b8b7eb5750e27"};
}

- (RMRequestMethod)requestMethod
{
    return RMRequestMethodPost;
}

- (RMRequestSerializerType)requestSerializerType
{
    return RMRequestSerializerTypeJSON;
}

- (RMResponseSerializerType)responseSerializerType
{
    return RMResponseSerializerTypeHTTP;
}

@end
