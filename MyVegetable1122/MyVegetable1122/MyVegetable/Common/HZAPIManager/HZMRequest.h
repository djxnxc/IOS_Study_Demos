//
//  HZMRequest.h
//  Mpos
//
//  Created by huazi on 14-10-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZMRequest : NSObject
@property (strong, nonatomic)NSString *requsetId;
@property (strong, nonatomic)NSDictionary *requestParamDic;
//** 99为passort 2 为 非*/
@property (nonatomic)NSInteger tag;
@property (weak, nonatomic) id callBackDelegate;
@end
