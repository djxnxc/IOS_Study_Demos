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
{
    NSMutableString *receiveStr;
}
@property(nonatomic,strong)NSMutableArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/**runtime方法交换
    //第一步获取方法名：
     Method A=class_getClassMethod(self, @selector(imageNamed:));
     Method B=class_getClassMethod(self, @selector(ln_imaheNamed:));
    //第二步交换方法
    Method_exchangeImplementions(A,B);
**/
/**runtime动态添加属性
    -(void)setName:(NSString *)name{
        objc_setAssociatedObject(self,@"name_key",name,OBJC_ASSOCIATION_RETAIN_NONATOMIC;
    }
    -(NSString *)name{
        return onjc_getAssociatedObject(self,@"name_key");
    }
 **/

/**runtime动态添加方法
    //添加对象方法
    void aaa(id self,SEL _cmd,NSNumber *length){
 
    }
    +(BOOL)resolveInstanceMethod:(SEL)sel{
        if (sel == NSSelectorFromString(@"run:")) {
            class_addMethod([Person class],sel,(IMP)aaa,"v@:@");
            return YES;
        }
        return [super resolveInstanceMethod:sel];
    }
    //在类中调用方式
    Person *p = [[Person alloc]init];
    [p performSelector:@selector(run:) withObject:100];
 
    //添加类方法
    void bbb(id self,SEL _cmd,NSNumber *length){
    }
    +(BOOL)resolveClassMethod:(SEL)sel{
        if(sel == NSSelectorFromString(@"eat:")){
            Class metaClass = Class_getMetaClass("Person");
            class_addMethod(metaClass,"v@:@");
            return YES;
        }
        return [super resolveClassMethod:sel];
    }
    //在类中调用方式
    [Person performSelector:@selector(eat:) withObject:100];
**/
    
/**runtime修改属性
    Person *p = [[Person alloc]init];
    unsigned int count = 0;
    objc_property_t  *propertyList= class_copyPropertyList([Person class], &count);
    for(int i =0 ;i<count;i++){
        objc_property_t property = propertyList[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if ([propertyName isEqualToString:@"age"]) {
            [p setValue:@"10" forKey:propertyName];
        }
    }
**/
/**runtime修改成员变量
    Person *p = [[Person alloc]init];
    unsigned int count = 0;
    Ivar *varList = class_copyIvarList([Person class],&count);
    for (int i = 0; i<count; i++) {
        Ivar var = varList[i];
        NSString *varName = [NSString stringWithUTF8String:ivar_getName(var)];
        if ([varName isEqualToString:@"sex"]) {
            object_setIvar(p, var, @"男");
        }
    }
**/
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
        //将属性的名称转成字符串类型
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        //property_getAttributes获取属性类型
        NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        if([propertyName isEqualToString:@"position"]){
            //给属性赋值（使用key-value）
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
     object_setIvar(p, var, @"李四")给成员变量var赋值
     object_getIvar(p, var)获取成员变量的值
     **/
        
        NSLog(@"*****runtime获取所有成员变量*****");
        unsigned int count = 0;
        Ivar *varList = class_copyIvarList([Person class], &count);
        for (int i = 0; i<count; i++) {
            Ivar var = varList[i];
            //将成员变量的名称转成字符串类型
            NSString *varName = [NSString stringWithUTF8String:ivar_getName(var)];
            //ivar_getTypeEncoding获取成员变量类型
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
//    [self AAA];
    [self test];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)test{
    Byte dataB[4];
    dataB[0] = 0xFF;
    dataB[1] = 0xa2;
    dataB[2] = 0xa3;
    dataB[3] = 0xa4;
    NSData *data =[NSData dataWithBytes:dataB length:4] ;
    Byte *dataByte =(Byte *)[data bytes];
    Byte firstByte[1];//每包的第一个字节
    firstByte[0] = dataByte[0];
    NSData *firstData = [NSData dataWithBytes:firstByte length:1];
    Byte endByte[1];//尾包第一个字节
    endByte[0] = (Byte) 0xFF;
    NSData *endData = [NSData dataWithBytes:endByte length:1];
    NSLog(@"--------->接收拼接");
    NSData *subData =[data subdataWithRange:NSMakeRange(1, [data length]-1)];
    NSString * tmpStr=[[NSString alloc]initWithData:subData encoding:NSUTF8StringEncoding];
    [receiveStr appendString:tmpStr];
    if ([firstData isEqual:endData]) {
        NSLog(@"--------->拼接结束");
        //数据接收结束,需要解析数据确定任务需要做什么,暂时不处理
        receiveStr = [NSMutableString string];
//        [self sendToBleWithJson:[self getJson]];
    }
}
-(void)AAA{
    self.arr = [NSMutableArray arrayWithCapacity:0];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"temp" ofType:@"txt"];

    NSString *dataFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [dataFile componentsSeparatedByString:@"\n"];
    for (NSString *str in array) {
//        NSLog(@"----%@\n",str);
        NSMutableString *str1 = [str mutableCopy];
        for (int i=0; i<str1.length; i++) {
//            NSLog(@"第%d个字符是:%c",i, [str1 characterAtIndex:i]);
            char commitChar = [str1 characterAtIndex:i];
            if((((commitChar>64)&&(commitChar<91))||[self change:commitChar])&&i!=0){
                [str1 insertString:@"," atIndex:i];
                i++;
            }
        }
        [self.arr addObject:str1];
    }
    NSError *error;
    NSString *newStr = [self.arr componentsJoinedByString:@"\n"];
    NSString *filePath2 = @"/Users/dengjiaxiang/Desktop/123.txt";
    [newStr writeToFile:filePath2 atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"导出失败:%@",error);
    }else{
        NSLog(@"导出成功");
    }

    
//    NSString *testString = @"ásolÁrbol";
//    NSInteger alength = [testString length];
//
//    for (int i = 0; i<alength; i++) {
//        char commitChar = [testString characterAtIndex:i];
//        NSLog(@"%hhd",commitChar);
//        NSString *temp = [testString substringWithRange:NSMakeRange(i,1)];
//        const char *u8Temp = [temp UTF8String];
//        if (3==strlen(u8Temp)){
//
//            NSLog(@"字符串中含有中文");
//        }else if((commitChar>64)&&(commitChar<91)){
//
//            NSLog(@"字符串中含有大写英文字母");
//        }else if((commitChar>96)&&(commitChar<123)){
//
//            NSLog(@"字符串中含有小写英文字母");
//        }else if((commitChar>47)&&(commitChar<58)){
//
//            NSLog(@"字符串中含有数字");
//        }else{
//
//            NSLog(@"字符串中含有非法字符");
//        }
//    }
}
-(BOOL)change:(char)c{
    if ([[NSString stringWithFormat:@"%c",c] isEqualToString:@"Á"]) {
        return YES;
    }
    if ([[NSString stringWithFormat:@"%c",c] isEqualToString:@"É"]) {
        return YES;
    }
    if ([[NSString stringWithFormat:@"%c",c] isEqualToString:@"Í"]) {
        return YES;
    }
    if ([[NSString stringWithFormat:@"%c",c] isEqualToString:@"Ó"]) {
        return YES;
    }
    if ([[NSString stringWithFormat:@"%c",c] isEqualToString:@"Ú"]) {
        return YES;
    }
    if ([[NSString stringWithFormat:@"%c",c] isEqualToString:@"Ñ"]) {
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
