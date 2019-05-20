//
//  NSString+Hash.m
//
//  Created by Tom Corwine on 5/30/12.
//

#import "NSString+Hash.h"
#include <stdlib.h>
#import "TDES.h"//3des

@implementation NSString (Hash)

+ (NSString*)encrypt3DES:(NSString*)plainText withKey:(NSString*)key{
//    NSString *mycode=[NSString stringWithFormat:@"%@", [NSString hexStringFromString:plainText]];
    NSString *mycode=[NSString stringWithFormat:@"%@", plainText];
    NSString *myUpperCaseStringCode=[mycode uppercaseString];
    NSString *my3DESCodeStr=[NSString stringWithFormat:@""];
    
    for (int i = 0; i <(plainText.length/16); i++) {
        NSRange range=NSMakeRange(i*16, 16);
//        NSString *iValue=[NSString stringWithFormat:@"%@",[myUpperCaseStringCode substringWithRange:range]];
        NSString *iValue=[NSString stringWithFormat:@"%@",[mycode substringWithRange:range]];

        char *data = [iValue UTF8String];
        char *myklk=[key UTF8String];
        char *outbuf[30];
        memset (outbuf,0x00,30);
        encrpt3DES(outbuf,data,myklk);
        NSString *encode = [[NSString alloc] initWithCString:(const char*)outbuf];
        my3DESCodeStr=[NSString stringWithFormat:@"%@%@",my3DESCodeStr,encode];
    }
    return my3DESCodeStr;
}

+ (NSString*)decrypt3DES:(NSString*)plainText withKey:(NSString*)key{
    
    NSString *mycode=[NSString stringWithFormat:@"%@", plainText];
    NSString *myUpperCaseStringCode=[mycode uppercaseString];
    NSString *my3DESCodeStr=[NSString stringWithFormat:@""];
    
    for (int i = 0; i <(plainText.length/16); i++) {
        NSRange range=NSMakeRange(i*16, 16);
        NSString *iValue=[NSString stringWithFormat:@"%@",[mycode substringWithRange:range]];

//        NSString *iValue=[NSString stringWithFormat:@"%@",[myUpperCaseStringCode substringWithRange:range]];
        char *data = [iValue UTF8String];
        char *myklk=[key UTF8String];
        char *outbuf[30];
        memset (outbuf,0x00,30);
        decrpt3DES(outbuf,data,myklk);
        NSString *encode = [[NSString alloc] initWithCString:(const char*)outbuf];
        my3DESCodeStr=[NSString stringWithFormat:@"%@%@",my3DESCodeStr,encode];
    }
    return my3DESCodeStr;
}

//普通字符串转换为十六进制的。

+(NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
// 十六进制转换为普通字符串的。
+(NSString *)stringFromHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

////明文密码进行3des加密
//+(NSString *)passwordTo3DES:(NSString *)password phoneNum:(NSString *)phoneNum{
//    return [self encrypt3DES:[[NSString stringWithFormat:@"%@0000000000000000000000000000000000000000000000000",password] substringToIndex:32]withKey:[phoneNum MD5]];
//}
////3des密文转成明文 key是手机号进行MD5加密后的字符串
//+(NSString *)passwordFrom3DES:(NSString *)password phoneNum:(NSString *)phoneNum passwordLength:(NSInteger)length{
//    return [[self decrypt3DES:password withKey:[phoneNum MD5]] substringToIndex:length];
//}
@end
