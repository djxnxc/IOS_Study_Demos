//
//  TransferMoneyVC.h
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferMoneyVC : UITableViewController
/**
 *type 1表示银行卡转账
 *type 2表示个人账户转账
 **/
@property(nonatomic,strong)NSString *amountStr;//转账金额
@property(nonatomic,strong)NSString *type;
@end
