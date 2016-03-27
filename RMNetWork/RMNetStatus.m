//
//  RMNetStatus.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "RMNetStatus.h"
#import "AFNetworking.h"

@implementation RMNetStatus

+ (RMNetStatus *)sharedInstance
{
    static RMNetStatus* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[RMNetStatus alloc] init];
        }
    });
    return _instance;
}

#pragma mark -network status

- (void)startRMNetworkMonitor {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"网络状态: wifi");
                _netWorkStatus = RMNetworkReachabilityStatusReachableViaWiFi;
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"网络状态: StatusUnknown");
                _netWorkStatus = RMNetworkReachabilityStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络状态: NotReachable");
                _netWorkStatus = RMNetworkReachabilityStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"网络状态: 2g/3g/4g");
                _netWorkStatus = RMNetworkReachabilityStatusReachableViaWWAN;
                break;
            default:
                break;
        }
    }];
}

- (BOOL)offline
{
    return ((self.netWorkStatus == RMNetworkReachabilityStatusNotReachable) ||
            (self.netWorkStatus == RMNetworkReachabilityStatusUnknown));
}

@end
