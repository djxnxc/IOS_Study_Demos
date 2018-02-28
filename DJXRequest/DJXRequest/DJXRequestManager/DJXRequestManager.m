//
//  DJXRequestManager.m
//  DJXRequest
//
//  Created by 12 on 2018/1/29.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "DJXRequestManager.h"
#import <AFNetworking.h>
static DJXRequestManager *_requestModel = nil;
@implementation DJXRequestManager
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestModel = [[[self class] alloc]init];
    });
    return _requestModel;
}
+(void)requestUrl:(NSString *)url withParams:(NSDictionary *)params withMethod:(RequestMethod)method success:(void(^)(NSURLSessionDataTask *task,id responseObject))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure{
    
    if (method == RequestMethodPost) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
     }
    else if(method == RequestMethodGet){
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:params progress:^(NSProgress *uploadProgress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            // 加载出错
        }];
    }
    
}

@end
