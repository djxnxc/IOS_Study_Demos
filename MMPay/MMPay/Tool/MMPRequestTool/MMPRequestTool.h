//
//  MMPRequestTool.h
//  MMPay
//
//  Created by 12 on 2017/12/6.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(id result);
typedef void (^ErrorBlock)(id error);
@interface MMPRequestTool : NSObject
//@property(nonatomic,copy)SuccessBlock successBlock;
//@property(nonatomic,copy)ErrorBlock errorBlock;
+(instancetype)shareManger;
/**
 *  发送post请求
 *
 *  URLStr  请求的网址字符串
 *  parameters 请求的参数
 *  success    请求成功的回调
 *  failure    请求失败的回调
 */
+ (void)postRequestWithURLStr:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(ErrorBlock)failureBlock;
@end
