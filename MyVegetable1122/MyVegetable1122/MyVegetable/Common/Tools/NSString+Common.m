

#import "NSString+Common.h"
#import "CommonCrypto/CommonDigest.h"
#import "Toast+UIView.h"
@implementation NSString (Common)
+(NSString *)MD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}
+(NSString *)Base64encode:(NSString *)encodeStr
{
    NSData *data = [encodeStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString* encoded =@"";
    //[[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    return encoded;
}

+(NSString *)Base64decode:(NSString *)decodeStr
{
    NSString *decoded =@"";
    //[[NSString alloc] initWithData:[GTMBase64 decodeString:decodeStr] encoding:NSUTF8StringEncoding];
    return decoded;
}
+(BOOL) isEmpty:(NSString *) str {
    
    if ([str isKindOfClass:[NSNull class]])
    {
        return true;
    }
    if (!str)
    {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
        
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)isValidateEmail:(NSString *)msg {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:msg];
}
//计算Size
+(CGSize)calculateTextSize:(CGSize)size Content:(NSString *)strContent  font:(UIFont *)font
{
    NSDictionary *tdic =[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    return [strContent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
}
//计算高度
+(CGFloat)calculateTextHeight:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font
{
    CGSize constraint = CGSizeMake(widthInput, 20000.0f);
    CGSize size = [strContent sizeWithFont:font constrainedToSize:constraint];
    CGFloat height = ceilf(size.height);
    return height;
}

//计算 宽度
+(CGFloat)calculateTextWidth:(CGFloat)widthInput Content:(NSString *)strContent  font:(UIFont *)font
{
    
    CGFloat constrainedSize = 150.0f; //其他大小也行
    CGSize size = [strContent sizeWithFont:font constrainedToSize:CGSizeMake(constrainedSize, 80)];
    CGFloat width = size.width;
    return width;
}
+(BOOL)isStandardPassword:(NSString *)str andView:(UIView *)view
{
    if (str.length >5&&str.length<33)
    {
        
        return YES;
    }
    else
    {
        [view makeToast:@"请输入6~32位字符" duration:1.0 position:@"center"];
        return NO;
    }
}
+(BOOL)isStandardFargatherName:(NSString *)str andView:(UIView *)view
{
    if ([NSString isEmpty:str])
    {
        [view makeToast:@"聚会名不能为空" duration:1.5 position:@"center"];
        return NO;
    }
    else
    {
    if (str.length >0&&str.length<11)
    {
        return YES;
    }
    else
    {
        [view makeToast:@"请输入1~10位字符" duration:1.5 position:@"center"];
        return NO;
    }
    }
}
+(NSString *)stringRemoveEmoji:(NSString *)stringRemoveEmoji
{
    return @"";
}
@end
