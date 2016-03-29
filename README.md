# RMNetWork

## Overview
A Objective-C wrapper around AFNetworking 3.0
## Basic usage

###1 Config baseURL & token if needed
     
    [RMBaseManagerConfig sharedInstance].baseURL = @"";
    [RMBaseManagerConfig sharedInstance].baseTokenKeyAndValue = @{@"accessToken":@"foo"};
    @required

###2 New request

####2.1 Subclass of RMBaseRequest

    @interface RMNetServiceFoo1API : RMBaseRequest <RMAPIConfig>
    @end

####2.2  New this subclass request and config request
In implementation of the subclass add config:
    
####Required methods
    
    - (NSString *)requestURL
    {
        return @"";
    }
    
    - (BOOL) isHTTPS
    {
        return YES;
    }
    
    - (RMRequestMethod)requestMethod
    {
        return RMRequestMethodPost;
    }
    
    - (RMRequestSerializerType)requestSerializerType
    {
        return RMRequestSerializerTypeJSON;
    }
    
    - (RMResponseSerializerType)responseSerializerType
    {
        return RMResponseSerializerTypeHTTP;
    }
 
####Optional methods 
     
    - (NSString *)baseURL
    {
        return @"https://www.foo.com";
    }
    
    - (NSDictionary *)tokenKeyAndValue
    
    {
        return @{@"accessToken":@"foo"};
    }
    
    - (id)parameters
    {
        return fooParams;
    }
    
    - (RMAFFormDataBlock)rmAFFormDataBlock
    {
        return fooBlock;
    }
    
    - (NSTimeInterval)timeoutInterval
    {
        return fooTimeInterval;
    }
  
####2.3 Handle response
Implementation RMRequestDelegate or block to handle reponse

    <RMRequestDelegate>
    - (void)requestDidSuccess:(RMBaseRequest *)request
    {
        NSLog(@"%@",request.responseObject);
    }
    
    - (void)requestDidFailure:(RMBaseRequest *)request
    {
        NSLog(@"%@",request.error);
    }
    
####3 Start net status Monitor

     [[RMNetStatus sharedInstance] startRMNetworkMonitor];

## License
MIT
