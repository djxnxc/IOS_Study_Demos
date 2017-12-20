//
//  TransferMoneyCell.m
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TransferMoneyCell.h"

@implementation TransferMoneyCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID";
    TransferMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TransferMoneyCell" owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
//转账按钮点击事件
- (IBAction)transferButClick:(UIButton *)sender {
    if (self.block) {
        self.block(@"transfer");
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.transferBut.layer.masksToBounds = YES;
    self.transferBut.layer.cornerRadius = 4;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
