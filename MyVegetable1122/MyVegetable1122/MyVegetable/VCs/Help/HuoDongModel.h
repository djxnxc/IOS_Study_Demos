//
//  HuoDongModel.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuoDongModel : NSObject
/**是否套装,默认0，套装1*/
@property (nonatomic, copy) NSString *isMore;//连接
/**套装几张 默认1张，多张则多张*/
@property (nonatomic, copy) NSString *num;//图片
/**热销？新品 热销0 新品1 ..*/
@property (nonatomic, copy) NSString *isNew;//标题
@property (nonatomic,strong)NSDictionary* infoData;


- (id)initWithDic:(NSDictionary *)dictionary;
@end
