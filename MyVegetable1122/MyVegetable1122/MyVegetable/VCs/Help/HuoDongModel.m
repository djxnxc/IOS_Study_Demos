//
//  HuoDongModel.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "HuoDongModel.h"
#import "Networking.h"
@implementation HuoDongModel
- (id)initWithDic:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.infoData=dictionary;
        self.isMore = [dictionary objectForKey:@"detailUrl"];
        self.num =[ResourUrl stringByAppendingPathComponent:[dictionary objectForKey:@"files"]];
        self.isNew = [dictionary objectForKey:@"title"];

    }
    return self;
}

@end
