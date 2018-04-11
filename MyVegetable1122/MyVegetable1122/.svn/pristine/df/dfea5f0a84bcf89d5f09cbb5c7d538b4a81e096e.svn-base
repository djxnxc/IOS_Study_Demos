//
//  JfriendGroupModel.h
//  QQ好友页面
//
//  Created by 蒋孝才 on 15/7/23.
//  Copyright (c) 2015年 JXC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JfriendGroupModel : NSObject

/**分组名称*/
@property (nonatomic, copy) NSString *name;
/**装好友模型*/
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, assign,getter=isExpand) BOOL expand;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
