//
//  HomeHeaderCell.m
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "HomeHeaderCell.h"

@implementation HomeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/**
 *扫一扫
 */
- (IBAction)ScanButClick:(UIButton *)sender {
    sender.tag = 100;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(homeVCButClick:)]) {
        [self.delegate homeVCButClick:sender];
    }
}
/**
 *付款
 */
- (IBAction)payButClick:(UIButton *)sender {
    sender.tag = 101;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(homeVCButClick:)]) {
        [self.delegate homeVCButClick:sender];
    }
}
/**
 *收款
 */
- (IBAction)collectButClick:(UIButton *)sender {
    sender.tag = 102;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(homeVCButClick:)]) {
        [self.delegate homeVCButClick:sender];
    }
}
/**
 *卡包
 */
- (IBAction)offersButClick:(UIButton *)sender {
    sender.tag = 103;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(homeVCButClick:)]) {
        [self.delegate homeVCButClick:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
