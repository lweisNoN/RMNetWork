//
//  RMNetServiceFactory.h
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMBaseRequest.h"

@interface RMNetServiceFactory : NSObject
+ (instancetype)sharedInstance;
- (RMBaseRequest <RMAPIConfig> *)newServiceWithIdentifier:(NSString *)identifier;
@end
