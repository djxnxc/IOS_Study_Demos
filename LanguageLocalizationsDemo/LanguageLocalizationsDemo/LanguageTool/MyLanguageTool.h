//
//  MyLanguageTool.h
//  LanguageLocalizationsDemo
//
//  Created by 12 on 2018/1/25.
//  Copyright © 2018年 djx. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MyGetStringWithKeyFromTable(key, tbl) [[MyLanguageTool sharedInstance] getStringForKey:key withTable:tbl]
@interface MyLanguageTool : NSObject
//单例
+(instancetype)shareInstance;

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table(table.strings)
 *
 *  @return 返回table中指定的key的值(该语言对应的值)
 */
-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;
/**
 *  设置语言
 *
 *  @param language 语言
 */
-(void)setMyLanguage:(NSString *)language;
@end
