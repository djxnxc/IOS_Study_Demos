//
//  BuyModel.m
//  MyVegetable
//
//  Created by mythkiven on 15/12/10.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "BuyModel.h"

@implementation BuyModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
- (id)initWithDic:(NSDictionary *)dic{
//    self.minInterest = [dic objectForKey:@"minInterest"];
    
    
    return self;
}
-(id)init{
    self=[super init];
    if (self) {

        self.title=@"";
        /**最低年化收益率*/
        self.minRate=0;
        /**最高年化收益率*/
       self.maxRate=0;
        /**剩余可购份额*/
        self.amount=0;
        /**进度*/
        self.progress=0;
        /**产品ID*/
        self.productId=0;
        /**产品标签*/
        self.label=@"";
        /**最小投资金额*/
        self.minInvestAmount=0;
        /**最大投资金额*/
        self.maxInvestAmount=0;
        /**最小投资份额的利息*/
        self.minInterest=0;
        /*倒计时时间*/
        self.timeLine=0;
        /*按钮状态*/
        self.buttonStatus=3;
        /**定期 周期*/
        self.cycle=0;
        /**定期 周期单位 日3月2年1*/
        self.cycleType=1;

        
    }
    return self;
}
@end
