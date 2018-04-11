//
//  AccountHQCellModel.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountHQCellModel.h"
#import "PublicString.h"

@implementation AccountHQCellModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self=[super init];
    if (self) {
       NSString *str = [NSString stringWithFormat:@"%@",dic[@"dateStr"]];
        if (str.length>=16) {
            str = [str substringToIndex:(str.length-9)];
        }
        self.time = str;
        
        NSString *s = [NSString stringWithFormat:@"%@",dic[@"type"]];
        if ([s isEqualToString:@"1"]) {
            self.style =@"购买";
        }else if ([s isEqualToString:@"2"]) {
            self.style =@"赎回";
        }else {
            self.style =@"-";
        }
        
        NSString *ss = [NSString stringWithFormat:@"%@",dic[@"amount"]];
        self.monkey =ss;
//        if ([ss isEqualToString:@"--"]) {
//            self.monkey =ss;
//        }else{
//            if ([ss isEqualToString:@"1"]) {
//                self.monkey =ss;
//            }else if ([ss isEqualToString:@"2"]) {
//                self.monkey =ss;
//            }
//        }
        NSString* st=@"0.00";
        if (dic[@"interestAmount"]) {
            
            st=[NSString stringWithFormat:@"%@",dic[@"interestAmount"]];

        }
        self.monkeyGet =st;//[NSString stringWithFormat:@"%@",dic[@"interestAmount"]];
    }
    return self;
}
@end
