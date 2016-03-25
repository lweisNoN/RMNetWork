//
//  RMRequestManager.h
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBaseRequest.h"

@interface RMRequestManager : NSObject
+ (instancetype)sharedInstance;
- (void)addRMRequest:(RMBaseRequest *)rmBaseRequest;
- (void)removeRMRequest:(RMBaseRequest *)rmBaseRequest;
- (void)removeAllRequests;

@end
