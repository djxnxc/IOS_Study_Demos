//
//  AccountDQModel.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/24.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountJLModel.h"

@implementation AccountJLModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self) {
//        self.type = dic[@""];
        if (dic[@"amount"]) {
            
            self.monkey = [NSString stringWithFormat:@"%@",dic[@"amount"]];
        }else{
            self.monkey=@"0.00";
        }
        if (dic[@"status"]) {
            self.isUseOrold = [NSString stringWithFormat:@"%@",dic[@"status"]];
//            1：未使用
            //        2：已使用
            //        3：已过期
            //        4：已回收
            self.statusName=@"未使用";
            switch ([dic[@"status"] intValue]) {
                case 1:
                    self.statusName=@"未使用";
                    break;
                case 2:
                    self.statusName=@"已使用";
                    break;
                case 3:
                    self.statusName=@"已过期";
                    break;
                case 4:
                    self.statusName=@"已回收";
                    break;
                    
                default:
                    break;
            }
        }else{
            self.isUseOrold=@"0";
        }
        if (dic[@"endTime"]) {
            self.effect = [NSString stringWithFormat:@"%@",dic[@"endTime"]];
        }else{
            self.effect=@"";
        }
        if (dic[@"activityName"]) {
           
            self.from = [NSString stringWithFormat:@"%@",dic[@"activityName"]];
        }else{
            self.from=@"";
        }
        if (dic[@"status"]) {
            self.status = [NSString stringWithFormat:@"%@",dic[@"status"]];
        }else{
            self.status=@"0";
        }
        self.condition=@"仅限新手标使用";
//        self.condition = dic[@""];
//        self.type = dic[@""];
//        self.type = dic[@""];
    }
    return self;
}
//@property (copy, nonatomic) NSString *type;

//@property (copy, nonatomic) NSString *monkey;
/**0 未 1 已经*/
//@property (copy, nonatomic) NSString *isUseOrold;

//@property (copy, nonatomic) NSString *from;

//@property (copy, nonatomic) NSString *effect;
//@property (copy, nonatomic) NSString *condition;










@end
