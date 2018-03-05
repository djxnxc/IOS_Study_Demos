//
//  TestModel.h
//  RuntimeStudy
//
//  Created by 12 on 2018/3/2.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "RModel.h"

@interface TestModel : RModel
{
    NSString *_weight;//成员变量
}
@property(nonatomic,copy)NSString *name;//属性
@property(nonatomic,copy)NSString *age;
@property(nonatomic,copy)NSString *school;
@end
