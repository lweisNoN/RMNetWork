//
//  RMBaseManager.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "RMBaseRequest.h"
#import "RMBaseManagerConfig.h"
#import "RMRequestManager.h"

@interface RMBaseRequest()
@property (nonatomic, copy, nonnull) NSString *baseURL;
@end

@implementation RMBaseRequest
#pragma mark - public methods

- (void)start
{
    [[RMRequestManager sharedInstance] addRMRequest:self];
}

- (void)stop
{
    [[RMRequestManager sharedInstance] removeRMRequest:self];
    self.requestDelegate = nil;
}

- (void)resume
{
    [[RMRequestManager sharedInstance] resumeRMRequest:self];
}

- (void)suspend
{
    [[RMRequestManager sharedInstance] suspendRMRequest:self];
}

- (void)stateOfRMRequest
{
    [[RMRequestManager sharedInstance] stateOfRMRequest:self];
}

- (void)startWithRequestSuccessBlock:(RMRequestCompletionBlock)success failureBlock:(RMRequestCompletionBlock)failure
{
    [self setRequestSuccessBlock:success failureBlock:failure];
    [self start];
}

- (void)clearCompletionBlock {
    self.requestSuccessBlock = nil;
    self.requestSuccessBlock = nil;
}

#pragma mark - private methods
- (void)setRequestSuccessBlock:(RMRequestCompletionBlock)success failureBlock:(RMRequestCompletionBlock)failure {
    self.requestSuccessBlock = success;
    self.requestFailureBlock = failure;
}

@end
