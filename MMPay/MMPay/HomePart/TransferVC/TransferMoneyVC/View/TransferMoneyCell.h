//
//  TransferMoneyCell.h
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferMoneyCell : UITableViewCell
@property(nonatomic,copy)void (^block)(NSString *str);
@property (weak, nonatomic) IBOutlet UIButton *transferBut;//转账按钮
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
