//
//  HttpRequest.h
//  T98
//
//  Created by mythkiven on 15/8/31.
//  Copyright (c) 2015年 yunhoo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpRequest : NSObject



+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


@end
