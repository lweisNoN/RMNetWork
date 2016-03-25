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

}

@end
