//
//  RMBaseManagerConfig.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "RMBaseManagerConfig.h"

@implementation RMBaseManagerConfig

#pragma mark - life cycle

+ (RMBaseManagerConfig *)sharedInstance
{
    static RMBaseManagerConfig* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[RMBaseManagerConfig alloc] init];
        }
    });
    return _instance;
}

@end
