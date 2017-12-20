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
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *banksTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBut;

@property(nonatomic,copy)butClickBlock block;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
