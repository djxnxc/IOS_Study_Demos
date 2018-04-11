//
//  PublicString.m
//  MyVegetable
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "PublicString.h"

@implementation PublicString
@synthesize isTransPassword,isTrueName;
static PublicString *pub=nil;
+(id)shareSDK
{
    if (pub==nil) {
        pub=[[PublicString alloc]init];
    }
    return pub;
}
+(NSString*)stringToMoney:(NSString*)money
{
    CGFloat mount=[money doubleValue];    //[money longValue];
    return [NSString stringWithFormat:@"%0.2f",mount];
}
-(void)transactionFailed:(HZMResponse *)response
{
    if (response.tag==0x9001) {
        int result=[[response.responseData objectForKey:@"code"] intValue];
        if (result==1) {
            self.isTrueName=YES;
        }else{
            self.isTrueName=NO;
        }
    }
    if (response.tag==0x9002) {
        int result=[[response.responseData objectForKey:@"code"] intValue];
        if (result==1) {
            self.isTransPassword=YES;
        }else{
            self.isTransPassword=NO;
        }
    }
}
-(void)transactionFinished:(HZMResponse *)response
{
    
}
-(void)checkPassword
{
    [[HZMAPImanager shareMAPImanager]addDelegate:self];
    HZMRequest* requset1=[[HZMRequest alloc]init];
    requset1.requsetId=Check_Info;
    WDCAccount *a1 = [WDCUserManage getLastUserInfo];
    NSDictionary* dict1=@{@"type":@(2),@"userId":a1.userId};
    requset1.requestParamDic=dict1;
    requset1.callBackDelegate=pub;
    requset1.tag=0x9002;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset1];
}
-(void)checkInfo
{
    [[HZMAPImanager shareMAPImanager]addDelegate:self];
    HZMRequest* requset=[[HZMRequest alloc]init];
    requset.requsetId=Check_Info;
    WDCAccount *a = [WDCUserManage getLastUserInfo];
    NSDictionary* dict=@{@"type":@(1),@"userId":a.userId};
    requset.requestParamDic=dict;
    requset.callBackDelegate=pub;
    requset.tag=0x9001;
    [[HZMAPImanager shareMAPImanager] postWithWSRequest:requset];
    
    
}
@end
