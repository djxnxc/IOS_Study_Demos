

#import "NSString+Zendai.h"

@implementation NSString (Zendai)
+ (NSString *)formatStringToDecimal:(NSString *)string digit:(NSInteger)digit decimalStyle:(BOOL)flag{
    if (!string.length) return @"";
    
    if (flag) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        string = [formatter stringFromNumber:[NSNumber numberWithDouble:string.doubleValue]];
    }
    
    NSArray *arr = [string componentsSeparatedByString:@"."];
    if (arr.count == 1) {
        if (!digit) return string;
        
        string = [string stringByAppendingString:@"."];
        for (int i = 0; i < digit; i ++) {
            string = [string stringByAppendingString:@"0"];
        }
        return string;
    } else {
        NSString *beforeString = arr[0];
        NSString *afterString = arr[1];
        
        if (digit == 0) {
            return [string componentsSeparatedByString:@"."][0];
        } else if (afterString.length >= digit) {
            return [NSString stringWithFormat:@"%@.%@",beforeString,[afterString substringToIndex:digit]];
        } else {
            NSUInteger c = digit - afterString.length;
            for (int k = 0; k < c; k ++) {
                string = [string stringByAppendingString:@"0"];
            }
            return string;
        }
    }
}

//保留两位小数+百分号
+ (NSString *)formatStringToDecimalWithPercent:(NSString *)string{
    if (!string.length) return @"";
    
    float a = [string floatValue];
    float b = a * 100;
    NSString * bstring = [NSString stringWithFormat:@"%f",b];
    NSArray *arr = [bstring componentsSeparatedByString:@"."];
    NSString *beforeString = arr[0];
    NSString *afterString = [arr[1] substringToIndex:2];
    return [NSString stringWithFormat:@"%@.%@%%",beforeString,afterString];
}

//银行卡号格式化
+ (NSString *)formatStringToBankNum:(NSString *)string{
    if (!string.length) return @"";
    NSMutableString *newString = [[NSMutableString alloc] initWithString:string];
    NSInteger count = string.length / 4;
    for (int i = 0; i < count; i++) {
        [newString insertString:@" " atIndex:4 + i*5];
    }
    if ([[newString substringWithRange:NSMakeRange(newString.length - 1, 1)] isEqualToString:@" "]) {
        return [newString substringToIndex:newString.length - 1];
    }
    return newString;
}

//label字体
+ (NSAttributedString *)attributeString:(NSString *)string fontSize:(NSUInteger)fontSize{
    if (string == nil || [string isEqualToString:@""]) {
        return nil;
    } else {
        NSInteger location = [string rangeOfString:@"~"].location;
        NSString *min = @"";
        NSString *max = @"";
        if (location != NSNotFound) {
            min = [string substringToIndex:location];
            max = [string substringFromIndex:location + 1];
            string = [NSString stringWithFormat:@"%@%%-%@%%",min,max];
            NSMutableAttributedString *strAttribute = [[NSMutableAttributedString alloc] initWithString:string];
            [strAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(min.length, 1)];
            [strAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(min.length + 2 + max.length, 1)];
            return strAttribute;
        } else {
            min = string;
            string = [NSString stringWithFormat:@"%@%%",min];
            NSMutableAttributedString *strAttribute = [[NSMutableAttributedString alloc] initWithString:string];
            [strAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(min.length, 1)];
            return strAttribute;
        }
    }
}

//label颜色
+ (NSAttributedString *)attributeColorString:(NSString *)string1 colorString:(NSString *)string2 fontSize:(NSUInteger)fontSize {
    if (string1 == nil || [string1 isEqualToString:@""]) {
        return nil;
    }
    else {
        NSString *str = [NSString stringWithFormat:@"%@%@",string1,string2];
        NSMutableAttributedString *strAttribute = [[NSMutableAttributedString alloc] initWithString:str];
        [strAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, string1.length)];
        [strAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string1.length)];
        return strAttribute;
    }
}

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

@end
