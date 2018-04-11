//
//  HZMResponse.h
//  Mpos
//
//  Created by huazi on 14-10-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZMResponse : NSObject
@property (strong, nonatomic) NSString *requestId;
@property (nonatomic)NSInteger tag;
@property (strong, nonatomic) NSString *responseCode;
@property (strong, nonatomic) NSString *responseMsg;
@property (strong, nonatomic) NSDictionary *responseData;
//自己添加
@property (strong, nonatomic) NSString  *responseCodeOriginal;
@property (weak, nonatomic) id callBackDelegate;
@end
