//
//  RMBaseManager.h
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class RMBaseRequest;

typedef void(^RMRequestCompletionBlock)(__kindof RMBaseRequest * _Nonnull request);
typedef void (^RMAFFormDataBlock)(id<AFMultipartFormData> __nonnull formData);

#pragma mark HTTP request method
typedef NS_ENUM(NSInteger , RMRequestMethod) {
    RMRequestMethodGet = 0,
    RMRequestMethodPost,
    RMRequestMethodHead,
    RMRequestMethodPut,
    RMRequestMethodDelete,
    RMRequestMethodPatch
};

#pragma mark request serializer type
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

#pragma mark response serializer type
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

#pragma mark network error code
typedef NS_ENUM(NSInteger , RMErrorCode) {
    RMRequestFormatError = 1000,
    RMRequestMethodError
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
- (NSTimeInterval)timeoutInterval;

@end

#pragma mark - RMRequestDelegate

@class RMBaseRequest;
@protocol RMRequestDelegate <NSObject>

@optional
- (void)requestDidSuccess:(RMBaseRequest * __nonnull)request;
- (void)requestDidFailure:(RMBaseRequest * __nonnull)request;
- (void)clearRequest;
@end

@interface RMBaseRequest : NSObject
@property (nonatomic, strong, nonnull) id responseObject;
@property (nonatomic, strong, nullable) NSError *error;
@property (nonatomic, strong, nonnull) NSURLSessionDataTask *task;

@property (nonatomic, copy, nullable) void (^uploadProgress)(NSProgress  * _Nullable progress);
@property (nonatomic, copy, nullable) void(^requestSuccessBlock)(RMBaseRequest * _Nonnull);
@property (nonatomic, copy, nullable) void(^requestFailureBlock)(RMBaseRequest * _Nonnull);

@property (nonatomic, weak, nullable) id <RMAPIConfig> config;
@property (nonatomic, weak, nullable) id <RMRequestDelegate> requestDelegate;

#pragma mark - RMNetwork Pulic Methods
- (void)start;
- (void)stop;
- (void)resume;
- (void)suspend;
- (void)stateOfRMRequest;

#pragma mark - RMRequestBlock
- (RMBaseRequest * _Nullable)startWithRequestSuccessBlock:(nonnull RMRequestCompletionBlock)success failureBlock:(nonnull RMRequestCompletionBlock)failure;
- (void)clearCompletionBlock;
@end


