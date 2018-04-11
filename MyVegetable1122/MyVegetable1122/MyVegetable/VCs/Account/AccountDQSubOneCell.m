//
//  AccountDQSubOneCell.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountDQSubOneCell.h"
#import "AccountDQModel.h"
@implementation AccountDQSubOneCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(AccountDQModel *)model {
    if (!model.isStop) {//未到期
        self.leftUp.textColor = RGB_yellow;
        self.rightUp.text = @"到期日";
    }else{//到期
        self.leftUp.textColor = [UIColor lightGrayColor];
        self.rightUp.text = @"已到期";
    }
    self.leftUp.text = model.leftUp;
    self.leftDOwn.text = model.leftDOwn;
    self.midUp.text = model.midUp;
    self.midDown.text = model.midDown;
    self.rightUp.text = model.rightUp;
    self.rightDown.text = model.rightDown;
}

-(int)compareDateFrom:(NSString*)date01 withDateNow:(NSString*)date02{
    
    if(!date02){
        NSDate *  timeDate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        //    [date formattersetDateFormat:@"HH:mm:ss"];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSString *  locationString=[dateformatter stringFromDate:timeDate];
        date02 = locationString;
    }
    
    
    
    
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result){
          //date02比date01大
        case NSOrderedAscending: ci=1; break;//到期
            //date02比date01小
        case NSOrderedDescending: ci=0; break;//未到期
            //date02=date01
        case NSOrderedSame: ci=1; break;//到期
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
            
    }
    return ci;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
