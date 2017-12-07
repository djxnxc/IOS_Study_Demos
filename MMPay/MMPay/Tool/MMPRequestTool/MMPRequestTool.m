//
//  MMPRequestTool.m
//  MMPay
//
//  Created by 12 on 2017/12/6.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MMPRequestTool.h"
static MMPRequestTool *_requestManager=nil;
@implementation MMPRequestTool
+(instancetype)shareManger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestManager = [[MMPRequestTool alloc]init];
    });
    return _requestManager;
}
+(void)postRequestWithURLStr:(NSString *)urlString parameters:(id)parameters success:(SuccessBlock)successBlock failure:(ErrorBlock)failureBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];
}
@end
