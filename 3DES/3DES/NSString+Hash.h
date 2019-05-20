//
//  NSString+Hash.m
//  mPOS
//
//  Created by 德益富 on 15/5/15.
//  Copyright (c) 2015年 Dyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)
//3des
+ (NSString*)encrypt3DES:(NSString*)plainText withKey:(NSString*)key;
+ (NSString*)decrypt3DES:(NSString*)plainText withKey:(NSString*)key;
//
/**
 *明文密码进行3des加密 key是手机号进行MD5加密后的字符串
 *password    密码明文
 *phoneNum    手机号（账号用来生成key）
 */
+(NSString *)passwordTo3DES:(NSString *)password phoneNum:(NSString *)phoneNum;
/**
 *3des密文转成明文 key是手机号进行MD5加密后的字符串
 *password   3des加密的密文
 *phoneNum   手机号（账号用来生成key）
 *length     密码明文的有效长度
 */
+(NSString *)passwordFrom3DES:(NSString *)password phoneNum:(NSString *)phoneNum passwordLength:(NSInteger)length;

+(NSString *)hexStringFromString:(NSString *)string;
// 十六进制转换为普通字符串的。
+(NSString *)stringFromHexString:(NSString *)hexString;
@end
