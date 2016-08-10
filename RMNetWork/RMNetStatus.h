//
//  RMNetStatus.h
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString * const RMNetWorkChangeNotification = @"rm.networking.offline";

@interface RMNetStatus : NSObject
typedef NS_ENUM(NSInteger, RMNetworkReachabilityStatus) {
    RMNetworkReachabilityStatusUnknown          = -1,
    RMNetworkReachabilityStatusNotReachable     = 0,
    RMNetworkReachabilityStatusReachableViaWWAN = 1,
    RMNetworkReachabilityStatusReachableViaWiFi = 2,
};

@property int netWorkStatus;

+ (RMNetStatus *)sharedInstance;
- (void)startRMNetworkMonitor;
- (BOOL) offline;

@end
