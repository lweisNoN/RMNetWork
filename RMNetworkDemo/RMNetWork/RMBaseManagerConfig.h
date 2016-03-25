//
//  RMBaseManagerConfig.h
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMBaseManagerConfig : NSObject
@property (nonatomic, strong, nonnull) NSString *baseURL;

+ (RMBaseManagerConfig * __nonnull)sharedInstance;
@end
