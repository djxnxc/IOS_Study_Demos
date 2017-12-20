//
//  TransferToBankCardCell.h
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void  (^butClickBlock)(NSString *str);
@interface TransferToBankCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;//name输入框
@property (weak, nonatomic) IBOutlet UITextField *cardNoTextField;//card No.输入框
@property (weak, nonatomic) IBOutlet UITextField *banksTextField;//banks输入框
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;//amount金额输入框
@property (weak, nonatomic) IBOutlet UIButton *nextBut;//下一步按钮

@property(nonatomic,copy)butClickBlock block;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
