//
//  DJXRequestManager.h
//  DJXRequest
//
//  Created by 12 on 2018/1/29.
//  Copyright © 2018年 djx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJXRequestManager : NSObject
typedef NS_ENUM(NSUInteger,RequestMethod){
    RequestMethodGet,
    RequestMethodPost
};
//单例
+(instancetype)shareInstance;
/**
 *
 *
 */
+(void)requestUrl:(NSString *)url withParams:(NSDictionary *)params withMethod:(RequestMethod)method success:(void(^)(NSURLSessionDataTask *task,id responseObject))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;
@end
