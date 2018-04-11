//
//  Tiyanjin.m
//  MyVegetable
//
//  Created by mythkiven on 15/12/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "Tiyanjin.h"

@implementation Tiyanjin
- (id)initWithDic:(NSDictionary *)dic {
    self=[super init];
    if (self) {
        self.couponId =[NSString stringWithFormat:@"%@",dic[@"id"]];
        self.amount  =[NSString stringWithFormat:@"%@",dic[@"amount"]];
        self.status=[dic[@"status"] intValue];
        self.getMode=[NSString stringWithFormat:@"%@",dic[@"activityName"]];
    }
    return self;
}
@end
