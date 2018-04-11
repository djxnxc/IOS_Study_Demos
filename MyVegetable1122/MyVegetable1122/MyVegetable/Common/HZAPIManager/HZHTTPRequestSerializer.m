//
//  HZHTTPRequestSerializer.m
//  Mpos
//
//  Created by huazi on 14-10-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import "HZHTTPRequestSerializer.h"

@implementation HZHTTPRequestSerializer
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = [super requestWithMethod:method URLString:URLString parameters:parameters];
    request.timeoutInterval = 10;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    return request;
}
@end
