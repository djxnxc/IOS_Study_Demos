//
//  AccountDQModel.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/24.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountJYModel.h"
#import "PublicString.h"
@implementation AccountJYModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self) {
        self.type = dic[@"type"];
        self.leftUp = dic[@"title"];
        self.leftDOwn = dic[@"dateStr"];
        
        NSString *ss =[NSString stringWithFormat:@"%@",dic[@"amount"]];
        ss = [NSString countNumAndChangeformat:ss];
        if ([self.type isEqualToString:@"1"]|[self.type isEqualToString:@"4"]) {
            self.rightUp =[NSString stringWithFormat:@"-%@",ss];
        }else{
            self.rightUp =[NSString stringWithFormat:@"+%@",ss];
        }
        
        
        NSString *s =[NSString stringWithFormat:@"%@",dic[@"useAmount"]];
        s = [NSString countNumAndChangeformat:s];
        self.rightDown = [NSString stringWithFormat:@"可用余额:￥%@",s];
        if ([dic objectForKey:@"status"]) {
            self.status=[[dic objectForKey:@"status"] intValue];
        }
    }
    return self;
}




@end
