//
//  TransferSuccessVC.h
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferSuccessVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;//转账方式
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;//金额label
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;//提示label
@property(nonatomic,copy)void (^finishlock)(NSString *str);
@property(nonatomic,strong)NSDictionary *dictData;
@end
