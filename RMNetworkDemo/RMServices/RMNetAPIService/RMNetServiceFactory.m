//
//  RMNetServiceFactory.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "RMNetServiceFactory.h"

// foo
NSString * const foo1API = @"RMNetServiceFoo1API";
NSString * const foo2API = @"RMNetServiceFoo2API";

@implementation RMNetServiceFactory

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RMNetServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RMNetServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (RMBaseRequest <RMAPIConfig> *)newServiceWithIdentifier:(NSString *)identifier
{
    // foo1
    if ([identifier isEqualToString:foo1API]) {
        return [[RMNetServiceFoo1API alloc] init];
    }
    
    // foo2
    if ([identifier isEqualToString:foo2API]) {
        return [[RMNetServiceFoo2API alloc] init];
    }
    
    return nil;
}

@end
