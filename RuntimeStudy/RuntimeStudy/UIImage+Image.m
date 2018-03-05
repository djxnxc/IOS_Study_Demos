//
//  UIImage+Image.m
//  RuntimeStudy
//
//  Created by 12 on 2018/3/1.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/message.h>

@implementation UIImage (Image)
/**
 load方法: 把类加载进内存的时候调用,只会调用一次
 方法应先交换，再去调用
 */
+(void)load{
    // 1.获取 imageNamed方法地址
    // class_getClassMethod（获取某个类的方法）
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    // 2.获取 ln_imageNamed方法地址
    Method ln_imageNamedMethod = class_getClassMethod(self, @selector(ln_imageNamed:));
    // 3.交换方法地址，相当于交换实现方式;「method_exchangeImplementations 交换两个方法的实现」
    method_exchangeImplementations(imageNamedMethod, ln_imageNamedMethod);
}
/**
    在调用imageNamed方法时实际调用的是ln_imageNamed方法
    所以并不会死循环
**/
+(UIImage *)ln_imageNamed:(NSString *)imageName{
    //调用ln_imageNamed方法时实际调用的是imageNamed方法
    UIImage *image = [UIImage ln_imageNamed:imageName];
    if (image) {
        NSLog(@"runtime---图片加载成功");
    }
    else{
        NSLog(@"runtime---图片加载失败");
    }
    return image;
}
-(void)setLab:(NSString *)lab{
    objc_setAssociatedObject(self, @"lab", lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString *)lab{
    return objc_getAssociatedObject(self, @"lab");
}
/**
 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super
 所以第二步，我们要 自己实现一个带有扩展功能的方法.
 + (UIImage *)imageNamed:(NSString *)name {
 
 }
 */

@end
