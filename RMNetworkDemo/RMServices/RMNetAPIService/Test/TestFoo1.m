//
//  TestFoo1.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "TestFoo1.h"

@implementation TestFoo1
+ (void)testFoo1:(id)delegate
{
    RMBaseRequest*request = [[RMNetServiceFactory sharedInstance] newServiceWithIdentifier:@"RMNetServiceFoo1API"];
    request.requestDelegate = delegate;
    [request start];
}

@end
