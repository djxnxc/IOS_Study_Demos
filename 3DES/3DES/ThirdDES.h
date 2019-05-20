//
//  ThirdDES.h
//  3DES
//
//  Created by 邓家祥 on 2018/9/14.
//  Copyright © 2018年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdDES : NSObject
/**  加密  **/

+ (NSString *)threeDESEncrypt:(NSString *)plainText withKey:(NSString *)key;



/**  解密  **/

+ (NSString *)threeDESDecrypt:(NSString *)plainText withKey:(NSString *)key;


@end
