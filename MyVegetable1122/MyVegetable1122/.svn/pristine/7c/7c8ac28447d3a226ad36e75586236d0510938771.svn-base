//
//  HZMAPImanager.m
//  Mpos
//
//  Created by huazi on 14-10-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import "HZMAPImanager.h"

@interface HZMAPImanager()<NSURLConnectionDelegate>
@property (nonatomic, strong) NSHashTable *delegates;
@end

@implementation HZMAPImanager


//- (AFSecurityPolicy*)customSecurityPolicy
//{
//    /**** SSL Pinning ****/
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"myselfsigned" ofType:@"cer"];
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    [securityPolicy setAllowInvalidCertificates:NO];
//    [securityPolicy setPinnedCertificates:@[certData]];
////    [securityPolicy setSSLPinningMode:AFSSLPinningModeCertificate];
//    /**** SSL Pinning ****/
//    
//    return securityPolicy;
//}






+(instancetype)shareMAPImanager
{
    static HZMAPImanager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[HZMAPImanager alloc] init];
        
    });
    return _manager;
}

-(id)init
{
    if (self)
    {
        self.delegates =[[NSHashTable alloc] init];
    }
    return self;
}

-(void)addDelegate:(id<HZMAPIManagerDelegate>)delegate
{
    @synchronized(self)
    {
        if (delegate && ![self.delegates containsObject:delegate]) {
            [self.delegates addObject:delegate];
        }
    }
}

-(void)removeDelegate:(id<HZMAPIManagerDelegate>)delegate
{
    @synchronized(self)
    {
        if (delegate && [self.delegates containsObject:delegate]) {
            [self.delegates removeObject:delegate];
        }
    }
}

#pragma mark - Private Help Method
- (void)postWithWSRequest:(HZMRequest *)wxRequest
{
    NSString *urlStr;
    if (wxRequest.tag == 99) {
        urlStr = [NSString stringWithFormat:@"%@",SERVICE_Passort_URL];
    }else{
        urlStr = [NSString stringWithFormat:@"%@",SERVICE_URL];
    }
    urlStr = [urlStr stringByAppendingString:wxRequest.requsetId];
    NSURL *baseURL = [NSURL URLWithString:urlStr];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 请求参数
//    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:wxRequest.requsetId,@"TXNCODE",[NSJSONSerialization returnJsonStrWithObject:wxRequest.requestParamDic],@"reqStr", nil];
    JLog(@"requestDic :%@--%@",wxRequest.requsetId,wxRequest.requestParamDic);
    [manager POST:urlStr parameters:wxRequest.requestParamDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString *str =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        HZMResponse *response = [[HZMResponse alloc] init];
        response.requestId = wxRequest.requsetId;
        response.tag = wxRequest.tag;
        response.responseData =[NSJSONSerialization returnObjectWithJsonStr:str];
        JLog(@"responseData :%@",response.responseData);
        response.callBackDelegate =wxRequest.callBackDelegate;
        
        //特殊情况
        if ([[response.responseData objectForKey:@"code"] isEqual: @-1]) {
            response.responseCodeOriginal = @"-1";
        }if ([[response.responseData objectForKey:@"code"] isEqual: @-2]) {
            response.responseCodeOriginal = @"-2";
        }if ([[response.responseData objectForKey:@"code"] isEqual: @-3]) {
            response.responseCodeOriginal = @"-3";
        }if ([[response.responseData objectForKey:@"code"] isEqual: @-4]) {
            response.responseCodeOriginal = @"-4";
        }if ([[response.responseData objectForKey:@"code"] isEqual: @1]) {
            response.responseCodeOriginal = @"1";
        }if ([[response.responseData objectForKey:@"code"] isEqual: @2]) {
            response.responseCodeOriginal = @"2";
        }if ([[response.responseData objectForKey:@"code"] isEqual: @3]) {
            response.responseCodeOriginal = @"3";
        }else{
            response.responseCodeOriginal = [NSString stringWithFormat:@"%@",[response.responseData objectForKey:@"code"]];
        }
        
//        if ([[response.responseData objectForKey:@"code"] isEqualToString:@"1"])
        if ([[response.responseData objectForKey:@"code"] isEqual: @1])
        {
            [response.callBackDelegate transactionFinished:response];
        }
        else
        {
            response.responseMsg =[response.responseData objectForKey:@"resdes"];
            if ([response.callBackDelegate respondsToSelector:@selector(transactionFailed:)])
            {
                if ([NSString isEmpty:str])
                {
                    response.responseMsg =@"数据返回异常, 请检查你的网络设置";
                    [response.callBackDelegate transactionFailed:response];
                }
                else
                {
                    [response.callBackDelegate transactionFailed:response];
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
         JLog(@"error.description%@",error.description);
         //DDLogInfo(@"%@", error);
         HZMResponse *response = [[HZMResponse alloc] init];
         response.requestId = wxRequest.requsetId;
         response.responseMsg = @"请求超时，请确定您的网络";
         response.callBackDelegate = wxRequest.callBackDelegate;
         if ([response.callBackDelegate respondsToSelector:@selector(transactionFailed:)])
         {
             [response.callBackDelegate transactionFailed:response];
         }
     }];
}

- (void)postWithWSRequestWithimageFile:(HZMRequest *)wxRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@",SERVICE_FILE_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[HZHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:wxRequest.requsetId,@"TXNCODE",[NSJSONSerialization returnJsonStrWithObject:wxRequest.requestParamDic],@"reqStr", nil];

    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *str =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         HZMResponse *response = [[HZMResponse alloc] init];
         response.requestId = wxRequest.requsetId;
         response.responseData =[NSJSONSerialization returnObjectWithJsonStr:str];
         response.callBackDelegate =wxRequest.callBackDelegate;
         if ([[response.responseData objectForKey:@"rescode"] isEqualToString:@"0"])
         {
             [response.callBackDelegate transactionFinished:response];
             
         }
         else
         {
             response.responseMsg =[response.responseData objectForKey:@"resdes"];
             if ([response.callBackDelegate respondsToSelector:@selector(transactionFailed:)])
             {
                 if ([NSString isEmpty:str])
                 {
                     response.responseMsg = @"字符中包含非法字符";
                     [response.callBackDelegate transactionFailed:response];
                 }
                 else
                 {
                     [response.callBackDelegate transactionFailed:response];
                 }
             }
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         JLog(@"%@",error.description);
         //DDLogInfo(@"%@", error);
         HZMResponse *response = [[HZMResponse alloc] init];
         response.requestId = wxRequest.requsetId;
         response.responseMsg =@"请求超时，请确定您的网络";
         response.callBackDelegate =wxRequest.callBackDelegate;
         if ([response.callBackDelegate respondsToSelector:@selector(transactionFailed:)])
         {
             [response.callBackDelegate transactionFailed:response];
         }
     }];
}

//下面两段是重点，要服务器端单项HTTPS 验证，iOS 客户端忽略证书验证。
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
}



@end
