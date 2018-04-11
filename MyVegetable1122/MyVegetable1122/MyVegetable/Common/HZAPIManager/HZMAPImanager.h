//
//  HZMAPImanager.h
//  Mpos
//
//  Created by huazi on 14-10-21.
//  Copyright (c) 2014年 huifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZMResponse.h"
#import "HZMRequest.h"
#import "HZHTTPRequestSerializer.h"

@protocol HZMAPIManagerDelegate <NSObject>

@optional

- (void)transactionFinished:(HZMResponse *)response;
- (void)transactionFailed:(HZMResponse *)response;

@end

@interface HZMAPImanager : NSObject
+(instancetype)shareMAPImanager;
-(void)addDelegate:(id<HZMAPIManagerDelegate>)delegate;
-(void)removeDelegate:(id<HZMAPIManagerDelegate>)delegate;

#pragma mark - Public method
- (void)postWithWSRequest:(HZMRequest *)wxRequest;
- (void)postWithWSRequestWithimageFile:(HZMRequest *)wxRequest;
@end
