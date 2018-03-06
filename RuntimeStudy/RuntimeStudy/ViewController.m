//
//  ViewController.m
//  RuntimeStudy
//
//  Created by 12 on 2018/3/1.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"
#import "TestModel.h"
#import "Person.h"
#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

/**
    runtime 交换方法
**/
    NSLog(@"-----runtime动态交换方法------");
    //由于使用runtime方法交换之后，实际调用的是ln_imageNamed:方法
    UIImage *image = [UIImage imageNamed:@"kong"];//图片为空
    UIImage *image1 = [UIImage imageNamed:@"icon_daxie"];//有图片
/**
    runtime 给分类动态添加属性
 **/
    image1.lab = @"image";
    NSLog(@"-----runtime动态给类添加属性------");
    NSLog(@"runtime添加属性---%@",image1.lab);
    
/**
    runtime字典转模型
 **/
    NSDictionary *dict = @{@"name":@"张三",@"age":@"18",@"sex":@"男"};
    TestModel *model = [TestModel modelWithDict:dict];
    NSLog(@"-----runtime字典转模型------");
    NSLog(@"runtime字典装模型----%@",model);
/**
    runtime 给类动态的添加方法
 **/
    NSLog(@"-----runtime动态添加方法------");
    Person *p = [[Person alloc] init];
    //对象方法
    [p performSelector:@selector(run:) withObject:@10];
    [p performSelector:@selector(eat:) withObject:@"米饭" withObject:@3];
    //类方法
    [Person performSelector:@selector(read:) withObject:@"英语书" withObject:@1];
/**
    runtime强制修改变量值(即使是私有变量也可以修改)
 **/
    NSLog(@"-----runtime动态修改变量------");
  
    NSLog(@"*****runtime获取所有成员变量*****");
    unsigned int count1 = 0;
    objc_property_t *propertyList = class_copyPropertyList(objc_getClass("Person"), &count1);
    for (int i = 0; i<count1; i++) {
        objc_property_t property = propertyList[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        if([propertyName isEqualToString:@"position"]){
            [p setValue:@"学生"forKey:@"position"];
        }
        NSLog(@"runtime获取属性---%d---%@---%@",i,propertyName,propertyType);
    /**
     runtime获取属性---0---position---T@"NSString",C,N,V_position
     T
     runtime获取属性---1---age---Tq,N,V_age
     T后面放的数据类型：
        q表示NSInteger类型
        d表示double类型
        @表示一个对象类型（字符串类型）
        B表示枚举类型
     **/
        
        NSLog(@"*****runtime获取所有成员变量*****");
        unsigned int count = 0;
        Ivar *varList = class_copyIvarList([Person class], &count);
        for (int i = 0; i<count; i++) {
            Ivar var = varList[i];
            NSString *varName = [NSString stringWithUTF8String:ivar_getName(var)];
            NSString *varType = [NSString stringWithUTF8String:ivar_getTypeEncoding(var)];
            if ([varName isEqualToString:@"_name"]) {
                object_setIvar(p, var, @"李四");
                NSLog(@"name=%@",object_getIvar(p, var));
            }
            if([varName isEqualToString:@"_position"]){
                NSLog(@"position=%@",object_getIvar(p, var));

            }
            NSLog(@"runtime获取所有成员变量---%d---%@---%@",i,varName,varType);
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
