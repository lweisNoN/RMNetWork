//
//  RMNetServiceFactory.h
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBaseRequest.h"
#import "RMNetServiceFoo1API.h"
#import "RMNetServiceFoo2API.h"

@interface RMNetServiceFactory : NSObject
+ (instancetype)sharedInstance;
- (RMBaseRequest <RMAPIConfig> *)newServiceWithIdentifier:(NSString *)identifier;
@end
