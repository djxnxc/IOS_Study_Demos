//
//  TransferMobileMoneyCell.m
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TransferMobileMoneyCell.h"
@interface TransferMobileMoneyCell()

@end
@implementation TransferMobileMoneyCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID";
    TransferMobileMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TransferMobileMoneyCell" owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.transferBut.layer.cornerRadius = 4;
    self.transferBut.layer.masksToBounds = YES;
    self.transferBut.enabled = NO;
    self.transferBut.backgroundColor = MMP_CUSTOM_COLOR(194, 226, 248, 1);
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // Initialization code
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length>0) {
        self.transferBut.enabled = YES;
        self.transferBut.backgroundColor = MMP_BLUECOLOR;
    }
    else{
        self.transferBut.enabled = NO;
        self.transferBut.backgroundColor = MMP_CUSTOM_COLOR(194, 226, 248, 1);
    }
    
}
//转账按钮点击事件
- (IBAction)transferButClick:(UIButton *)sender {
    [self endEditing:YES];
    if (self.block) {
        self.block(@"transfer");
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
