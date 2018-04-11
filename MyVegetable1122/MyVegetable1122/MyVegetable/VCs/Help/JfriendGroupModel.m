//
//  JfriendGroupModel.m
//  QQ好友页面
//
//  Created by 蒋孝才 on 15/7/23.
//  Copyright (c) 2015年 JXC. All rights reserved.
//

#import "JfriendGroupModel.h"
#import "JMessageFrameModel.h"
@implementation JfriendGroupModel

+ (instancetype)groupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        // 1、KVC
        [self setValuesForKeysWithDictionary:dict];
        // 2、因为有装另外一个模型的数组属性，所以最好提前把装另外model字典的数组的属性实际装入model字典的数组
        // 3、此处操作直接将另外一个model全部装入friends中
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in self.friends) {
            JfriendGroupModel *jf = [JfriendGroupModel groupWithDict:dict];
            [mArr addObject:jf];
        }
        self.friends = mArr;
        
    }
    return self;
}

@end
