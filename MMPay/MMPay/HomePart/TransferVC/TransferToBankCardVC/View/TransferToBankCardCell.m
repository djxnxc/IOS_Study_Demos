//
//  TransferToBankCardCell.m
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TransferToBankCardCell.h"
@interface TransferToBankCardCell()<UITextFieldDelegate>

@end
@implementation TransferToBankCardCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID";
    TransferToBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TransferToBankCardCell" owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nextBut.layer.cornerRadius = 4;
    self.nextBut.layer.masksToBounds = YES;
    self.nextBut.enabled = NO;
    self.nameTextField.delegate = self;
    self.cardNoTextField.delegate = self;
    self.amountTextField.delegate = self;
    [self.nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.cardNoTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.amountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    // Initialization code
}

//点击输入框按钮
- (IBAction)cellButClick:(UIButton *)sender {
    if (self.block) {
        self.block(@"banks");
    }
}
//点击下一步按钮
- (IBAction)nextButClick:(UIButton *)sender {
    if (self.block) {
        self.block(@"next");
    }
}
#pragma mark - UITextFeild代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField{
    if ([self.nameTextField.text isEqualToString:@""]) {
        self.nextBut.enabled = NO;
        self.nextBut.backgroundColor = MMP_CUSTOM_COLOR(194, 226, 248, 1);
        return ;
    }
    if ([self.cardNoTextField.text isEqualToString:@""]) {
        self.nextBut.enabled = NO;
        self.nextBut.backgroundColor = MMP_CUSTOM_COLOR(194, 226, 248, 1);
        return ;
    }
    if ([self.banksTextField.text isEqualToString:@""]) {
        self.nextBut.enabled = NO;
        self.nextBut.backgroundColor = MMP_CUSTOM_COLOR(194, 226, 248, 1);
        return ;
    }
    if ([self.amountTextField.text isEqualToString:@""]) {
        self.nextBut.enabled = NO;
        self.nextBut.backgroundColor = MMP_CUSTOM_COLOR(194, 226, 248, 1);
        return ;
    }
    self.nextBut.enabled = YES;
    self.nextBut.backgroundColor = MMP_BLUECOLOR;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
