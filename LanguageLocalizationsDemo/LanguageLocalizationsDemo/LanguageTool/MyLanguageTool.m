//
//  MyLanguageTool.m
//  LanguageLocalizationsDemo
//
//  Created by 12 on 2018/1/25.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "MyLanguageTool.h"
static MyLanguageTool *_tool;
@implementation MyLanguageTool
+(instancetype)shareInstance{
    if (!_tool) {
        _tool = [[MyLanguageTool alloc]init];
    }
    return _tool;
}
-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table
{
    NSString *tmp = [[NSUserDefaults standardUserDefaults]objectForKey:@"langeuageset"];
    NSString *path = [[NSBundle mainBundle]pathForResource:tmp ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    if (bundle)
    {
        return NSLocalizedStringFromTableInBundle(key, table, bundle, @"");
    }
    return NSLocalizedStringFromTable(key, table, @"");
}
-(void)setMyLanguage:(NSString *)language{
    [[NSUserDefaults standardUserDefaults]setObject:language forKey:@"langeuageset"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
