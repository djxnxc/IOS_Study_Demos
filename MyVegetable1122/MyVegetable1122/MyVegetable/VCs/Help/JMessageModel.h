//
//  JMessageModel.h
//  QQ聊天布局
//
//  Created by 蒋孝才 on 15/7/18.
//  Copyright (c) 2015年 JXC. All rights reserved.
//




/**
 
 用于装cell里面的数据而建的模型
 涵盖属性以及model的填充+—方法
 
 */

#import <Foundation/Foundation.h>


@interface JMessageModel : NSObject

/**聊天内容*/
@property (nonatomic, copy)     NSString    *text;
/**标题*/
@property (nonatomic, copy)     NSString    *title;


/**model的初始化方法*/
+ (instancetype)messageWithDict:(NSDictionary *)dict;
/**model的初始化方法*/
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
