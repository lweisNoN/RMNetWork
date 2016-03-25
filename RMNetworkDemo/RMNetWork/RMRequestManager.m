//
//  RMRequestManager.m
//  RMNetworkDemo
//
//  Created by luhai on 3/24/16.
//  Copyright © 2016 luhai. All rights reserved.
//

#import "RMRequestManager.h"
#import "RMNetStatus.h"
#import "RMBaseManagerConfig.h"

#define DEF_TimeoutInterval 60
#define DEF_MaxConcurrentRequestCount 5


@interface RMRequestManager ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary *requestQueue;
@end

@implementation RMRequestManager

#pragma mark - life cycle

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RMRequestManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RMRequestManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.requestQueue = [NSMutableDictionary dictionary];
        self.maxConcurrentRequestCount = DEF_MaxConcurrentRequestCount;
    }
    return self;
}

#pragma mark - public methods

- (void)addRMRequest:(RMBaseRequest *)rmBaseRequest
{
//    //check offline
//    if([RMNetStatus sharedInstance].offline)
//    {
//        NSError *error = [NSError errorWithDomain:@"network un work" code:600 userInfo:nil];
//        rmBaseRequest.error = error;
//        [self requestDidFinishWithRequest:rmBaseRequest];
//        
//        return;
//    }
    
    //check parameters json
    id params = nil;
    
    if ([rmBaseRequest.config respondsToSelector:@selector(parameters)]) {
        params = rmBaseRequest.config.parameters;
    }
    
    /**
     TODO List
     序列化json
     */
    
    if (rmBaseRequest.config.requestSerializerType == RMRequestSerializerTypeJSON) {
        if (![NSJSONSerialization isValidJSONObject:params] && params) {
            NSError *error = [NSError errorWithDomain:@"params can not be converted to JSON data" code:600 userInfo:nil];
            rmBaseRequest.error = error;
            [self requestDidFinishWithRequest:rmBaseRequest];
            
            return;
        }
    }
    
    //generate url
    NSString *requestURL = [self generateURLWithRequest:rmBaseRequest];
    
    //generate request
    [self genrateHeaderAndBodyWithRequest:rmBaseRequest];
    
    //start request
    RMRequestMethod requestMethod = rmBaseRequest.config.requestMethod;
    NSURLSessionDataTask *task = nil;
    switch (requestMethod) {
            case RMRequestMethodGet:
            break;
            case RMRequestMethodPost:
            if ([rmBaseRequest.config respondsToSelector:@selector(rmAFFormDataBlock)]) {
                task = [self.sessionManager POST:requestURL parameters:params constructingBodyWithBlock:rmBaseRequest.config.rmAFFormDataBlock progress:^(NSProgress * _Nonnull uploadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self handleReponseResult:task response:responseObject error:nil];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self handleReponseResult:task response:nil error:error];
                }];
            } else {
                task = [self.sessionManager POST:requestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self handleReponseResult:task response:responseObject error:nil];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self handleReponseResult:task response:nil error:error];
                }];
            }

            break;
            case RMRequestMethodPut:
            break;
            case RMRequestMethodHead:
            break;
            case RMRequestMethodPatch:
            break;
            case RMRequestMethodDelete:
            break;
            
            default:
            break;
    }
    
    //fork
    rmBaseRequest.task = task;
    [self addRequest:rmBaseRequest];
}

- (void)removeRMRequest:(RMBaseRequest *)rmBaseRequest
{
    [rmBaseRequest.task cancel];
    [self removeRequest:rmBaseRequest.task];
}

- (void)removeAllRequests
{
    for (NSString *key in self.requestQueue) {
        RMBaseRequest *request = self.requestQueue[key];
        [self removeRMRequest:request];
    }
}

#pragma mark - private methods

- (void)addRequest:(RMBaseRequest *)request {
    if (request.task) {
        NSString *key = [self taskHashKey:request.task];
        @synchronized(self) {
            [self.requestQueue setValue:request forKey:key];
        }
    }
}

- (void)removeRequest:(NSURLSessionDataTask *)task {
    NSString *key = [self taskHashKey:task];
    @synchronized(self) {
        [self.requestQueue removeObjectForKey:key];
    }
}

- (NSString *)taskHashKey:(NSURLSessionDataTask *)task {
    return [NSString stringWithFormat:@"%lu", (unsigned long)[task hash]];
}

- (NSString *)generateURLWithRequest:(RMBaseRequest *)request {
    
    /**
     TODO List
     校验请求格式
     */
    NSString *baseurl = [RMBaseManagerConfig sharedInstance].baseURL;

    if ([request.config respondsToSelector:@selector(baseURL)]) {
        baseurl = request.config.baseURL;
    }
    
    
    if ([baseurl hasPrefix:@"http"]) {
        return [NSString stringWithFormat:@"%@%@", baseurl, request.config.requestURL];
    } else {
        NSLog(@"error: baseURL: %@ requestURL: %@", baseurl, request.config.requestURL);
        return @"";
    }
}

- (void)genrateHeaderAndBodyWithRequest:(RMBaseRequest *)request {
    RMRequestSerializerType requestSerializerType = request.config.requestSerializerType;
    switch (requestSerializerType) {
        case RMRequestSerializerTypeForm:
            self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case RMRequestSerializerTypeJSON:
            self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        default:
            self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
    }
    
    RMResponseSerializerType responseSerializerType = request.config.responseSerializerType;
    switch (responseSerializerType) {
        case RMResponseSerializerTypeJSON:
            self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case RMResponseSerializerTypeHTTP:
            self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
    }
    
    //timeout
    if ([request.config respondsToSelector:@selector(timeoutInterval)]) {
        self.sessionManager.requestSerializer.timeoutInterval = request.config.timeoutInterval;
    } else {
        self.sessionManager.requestSerializer.timeoutInterval = DEF_TimeoutInterval;
    }
    
    //security
    self.sessionManager.securityPolicy.allowInvalidCertificates = request.config.isHTTPS;
    self.sessionManager.securityPolicy.validatesDomainName = !request.config.isHTTPS;
    
    //Accept
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/xml", @"text/plain", @"text/json", @"text/javascript", @"image/png", @"image/jpeg", @"application/json", nil];
    
    //token
    if ([request.config respondsToSelector:@selector(token)]) {
        [self.sessionManager.requestSerializer setValue:request.config.token forHTTPHeaderField:@"accessToken"];
    } else {
        if ([RMBaseManagerConfig sharedInstance].baseURL != nil) {
            [self.sessionManager.requestSerializer setValue:[RMBaseManagerConfig sharedInstance].baseURL forHTTPHeaderField:@"accessToken"];
        }
    }
}

#pragma mark - result handle
- (void)handleReponseResult:(NSURLSessionDataTask *)task response:(id)responseObject error:(NSError *)error {
    //find task
    NSString *key = [self taskHashKey:task];
    RMBaseRequest *request = self.requestQueue[key];
    request.responseObject = responseObject;
    request.error = error;
    
    // 返回数据
    [self requestDidFinishWithRequest:request];
    
    // 请求成功后移除此次请求
    [self removeRequest:task];
}

- (void)requestDidFinishWithRequest:(RMBaseRequest *)request {
    
    if (request.error) {
        if ([request.requestDelegate respondsToSelector:@selector(requestDidFailure:)]) {
            [request.requestDelegate requestDidFailure:request];
        }
    } else {
        
        if ([request.requestDelegate respondsToSelector:@selector(requestDidSuccess:)]) {
            [request.requestDelegate requestDidSuccess:request];
        }
    }
    
    /**
     TODO
     block回调数据
     */
}

#pragma mark - getters&etters

- (void)setMaxConcurrentRequestCount:(NSInteger)maxConcurrentRequestCount {
    self.sessionManager.operationQueue.maxConcurrentOperationCount = maxConcurrentRequestCount;
}

@end
