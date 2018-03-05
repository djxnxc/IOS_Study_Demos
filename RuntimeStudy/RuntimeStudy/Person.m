//
//  Person.m
//  RuntimeStudy
//
//  Created by 12 on 2018/3/5.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
@implementation Person

/**
 C语言函数至少包含两个参数self _cmd（self 代表着函数本身，而 _cmd 则是一个 SEL 数据体，包含了具体的方法地址
 **/
void aaa(id self, SEL _cmd, NSNumber *meter) {
    NSLog(@"runtime动态添加对象方法1----跑了%@米", meter);
}

void bbb(id self, SEL _cmd, NSString *type,NSNumber *number){
    NSLog(@"runtime动态添加对象方法2----吃了%@碗的%@", number,type);

}
void ccc(id self,SEL _cmd,NSString *type,NSNumber *time){
    NSLog(@"runtime动态添加类方法----小明早上读了%@%@小时",type,time);
}
// 任何方法默认都有两个隐式参数,self,_cmd（当前方法的方法编号）
// 什么时候调用:只要一个对象调用了一个未实现的方法就会调用这个方法,进行处理
// 作用:动态添加对象方法,处理未实现
+ (BOOL)resolveInstanceMethod:(SEL)sel//对象方法时调用
{
    NSLog(@" >> Instance resolving %@", NSStringFromSelector(sel));

    // [NSStringFromSelector(sel) isEqualToString:@"run"];
    if (sel == NSSelectorFromString(@"run:")) {
        // 动态添加run方法
        // class: 给哪个类添加方法
        // SEL: 添加哪个方法，即添加方法的方法编号
        // IMP: 方法实现 => 函数 => 函数入口 => 函数名（添加方法的函数实现（函数地址））
        // type: 方法类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        return YES;
    }
    if(sel == NSSelectorFromString(@"eat:")){
        class_addMethod(self, sel, (IMP)bbb, "v@:@@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
+(BOOL)resolveClassMethod:(SEL)sel//类方法时调用
{
    NSLog(@" >> Class resolving %@", NSStringFromSelector(sel));

    if (sel == NSSelectorFromString(@"read:")) {
        Class kclass=objc_getMetaClass("Person");//要获取元类(不能直接用self),将添加到元类否则会crash
        class_addMethod(kclass, sel, (IMP)ccc, "v@:@@");
        return YES;
    }
    return [super resolveClassMethod:sel];
}
@end
