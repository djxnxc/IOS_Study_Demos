//
//  AccountDQSubOneCell.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountJLSubOneCell.h"
#import "AccountJLModel.h"
@implementation AccountJLSubOneCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(AccountJLModel *)model {
//    self.model = model;
//    if ([model.type isEqualToString:@"1"]) {//红包
//        1：未使用
//        2：已使用
//        3：已过期
//        4：已回收
    self.statusShow.text=model.statusName;
        if ([model.isUseOrold isEqualToString: @"1"]) {//未使用
            [self.isUseOrold setImage:[UIImage imageNamed:@"staR"]];
            [self.hongbaoBg setImage:[UIImage imageNamed:@"account_hongbao"]];
            [self.hongbaoXX setImage:[UIImage imageNamed:@"xuxian_red"]];
            self.monkey.textColor=[UIColor redColor];
        }else{
            [self.isUseOrold setImage:[UIImage imageNamed:@"staG"]];
            [self.hongbaoBg setImage:[UIImage imageNamed:@"account_hongbao_enable"]];
            [self.hongbaoXX setImage:[UIImage imageNamed:@"xuxian1"]];
             self.monkey.textColor = RGB(117, 117, 117, 1);
            self.hongbaoMonkey.textColor = [UIColor whiteColor];
        }
    NSString * s = [NSString countNumAndChangeformat:model.monkey];
        self.monkey.text = [NSString stringWithFormat:@"￥%@",s];
        self.type.text = @"类型:定期红包";
        self.from.text = [NSString stringWithFormat:@"来源:%@",model.from];
        self.effect.text = [NSString stringWithFormat:@"有效期:%@",model.effect];
        //self.condition1.text = [NSString stringWithFormat:@"使用规则:%@",model.condition];
        //self.hongbaoMonkey.text = [NSString stringWithFormat:@"%@元",s];
        
        
//    }
    
}
- (void)layoutSubviews {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end