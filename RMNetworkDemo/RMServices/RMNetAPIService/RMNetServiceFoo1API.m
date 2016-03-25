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
    return @"http://www.baidu.com";
}

- (NSString *)token
{
    return @"";
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
    return RMResponseSerializerTypeJSON;
}

@end
