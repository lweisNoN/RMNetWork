//
//  AppDelegate.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "AppDelegate.h"
#import "RMNetServiceFactory.h"
#import "RMNetStatus.h"
#import "RMBaseManagerConfig.h"
#import "TestFoo1.h"

@interface AppDelegate () <RMRequestDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[RMNetStatus sharedInstance] startRMNetworkMonitor];
    [RMBaseManagerConfig sharedInstance].baseURL = @"";
    [RMBaseManagerConfig sharedInstance].baseTokenKeyAndValue = @{@"accessToken":@"0619eab0-d1d5-4d54-975e-d0cbe724a6c76c00fd02f0f9d791991b8b7eb5750e27"};

    [TestFoo1 testFoo1:self];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)requestDidSuccess:(RMBaseRequest *)request
{
    NSLog(@"%@",request.responseObject);
}

- (void)requestDidFailure:(RMBaseRequest *)request
{
    NSLog(@"%@",request.error);
}

@end
