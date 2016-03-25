//
//  RMNetServiceFoo1API.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "RMNetServiceFoo1API.h"

@implementation RMNetServiceFoo1API
- (NSString *)requestURL
{
    return @"foo1/test";
}

- (BOOL) isHTTPS
{
    return YES;
}

- (NSString *)baseURL
{
    return @"API/2.0/";
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
