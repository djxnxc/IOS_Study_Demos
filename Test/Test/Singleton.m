//
//  Singleton.m
//  Test
//
//  Created by 12 on 2018/3/13.
//  Copyright © 2018年 DJX. All rights reserved.
//

#import "Singleton.h"
static Singleton *_instance=nil;
@implementation Singleton

+(Singleton *)shareInstance{
    dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [[Singleton alloc]init];
    });
    return _instance;
}
+(id)allocWithZone:(struct _NSZone*)zone{
    dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
    
}
@end
