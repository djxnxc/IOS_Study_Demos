//
//  ZendaiUserManage.h
//  ZenDaiWallet
//
//  Created by 李永超 on 15-2-3.
//
//

#import <Foundation/Foundation.h>

@class WDCAccount;

@interface WDCUserManage : NSObject

+(void)saveLastUserInfo:(WDCAccount *)g_account;

+(void)removeLastUserInfo;

+ (WDCAccount *)getLastUserInfo;
+ (WDCUserManage *)sharedWDCUserManage;



@end
