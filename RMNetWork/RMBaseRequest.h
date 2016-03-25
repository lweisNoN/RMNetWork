//
//  RMBaseManager.h
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^completion_handler_t)(id __nullable, NSError* __nullable);
typedef void (^RMAFFormDataBlock)(id<AFMultipartFormData> __nonnull formData);

/**
 *  HTTP request method
 */
typedef NS_ENUM(NSInteger , RMRequestMethod) {
    RMRequestMethodGet = 0,
    RMRequestMethodPost,
    RMRequestMethodHead,
    RMRequestMethodPut,
    RMRequestMethodDelete,
    RMRequestMethodPatch
};

/**
 *  request serializer type
 */
typedef NS_ENUM(NSInteger, RMRequestSerializerType) {
    /**
     *  content-type: application/x-www-form-urlencoded not json type
     */
    RMRequestSerializerTypeForm = 0,
    /**
     *  content-type: application/json
     */
    RMRequestSerializerTypeJSON
};

/**
 *  response serializer type
 */
typedef NS_ENUM(NSInteger, RMResponseSerializerType) {
    /**
     *  get the origin data from server
     */
    RMResponseSerializerTypeHTTP= 0,
    /**
     *  JSON from server
     */
    RMResponseSerializerTypeJSON
};

#pragma mark - RMAPIConfig
/**
 RMBaseManager的派生类必须符合 RMAPIConfig protocal,对子类API进行配置
 */
@protocol RMAPIConfig <NSObject>

@required
- (BOOL)isHTTPS;
- (nonnull NSString *)requestURL;
- (RMRequestMethod) requestMethod;
- (RMRequestSerializerType) requestSerializerType;
- (RMResponseSerializerType) responseSerializerType;

@optional
- (nonnull NSDictionary *)tokenKeyAndValue;
- (nonnull NSString *)baseURL;
- (nonnull id)parameters;
- (nonnull RMAFFormDataBlock)rmAFFormDataBlock;
- (BOOL)timeoutInterval;

@end

#pragma mark - RMRequestDelegate
/**
 返回数据代理
 */
@class RMBaseRequest;
@protocol RMRequestDelegate <NSObject>

@optional
- (void)requestDidSuccess:(RMBaseRequest * __nonnull)request;
- (void)requestDidFailure:(RMBaseRequest * __nonnull)request;
- (void)clearRequest;
@end

#pragma mark - RMRequestBlock
/**
 TODO List
 block回调数据
 */

@interface RMBaseRequest : NSObject
@property (nonatomic, weak, nullable) id <RMAPIConfig> config;
@property (nonatomic, weak, nullable) id <RMRequestDelegate> requestDelegate;
@property (nonatomic, strong, nonnull) NSURLSessionDataTask *task;
@property (nonatomic, strong, nonnull) id responseObject;
@property (nonatomic, strong, nullable) NSError *error;

#pragma mark - RMNetwork
- (void)start;
- (void)stop;

@end


