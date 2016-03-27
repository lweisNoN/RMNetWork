//
//  RMNetServiceFoo2API.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "RMNetServiceFoo2API.h"

@implementation RMNetServiceFoo2API
- (NSString *)requestURL
{
    return @"foo2/test";
}

- (BOOL)isHTTPS
{
    return NO;
}

- (RMRequestMethod)requestMethod
{
    return RMRequestMethodGet;
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
