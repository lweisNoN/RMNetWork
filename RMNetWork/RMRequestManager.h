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
@property (nonatomic) NSUInteger maxConcurrentRequestCount;

+ (instancetype)sharedInstance;
- (void)addRMRequest:(RMBaseRequest *)rmBaseRequest;
- (void)suspendRMRequest:(RMBaseRequest *)rmBaseRequest;
- (void)resumeRMRequest:(RMBaseRequest *)rmBaseRequest;
- (NSURLSessionTaskState)stateOfRMRequest:(RMBaseRequest *)rmBaseRequest;
- (void)removeRMRequest:(RMBaseRequest *)rmBaseRequest;
- (void)removeAllRequests;

@end
