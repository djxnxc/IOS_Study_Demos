//
//  DesUtil.h
//  3DES
//
//  Created by 邓家祥 on 2018/9/23.
//  Copyright © 2018年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DesUtil : NSObject
/**
 DES加密
 */
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

/**
 DES解密
 */
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
