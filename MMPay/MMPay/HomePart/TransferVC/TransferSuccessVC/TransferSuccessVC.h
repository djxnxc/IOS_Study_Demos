//
//  TransferSuccessVC.h
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferSuccessVC : UIViewController

@property(nonatomic,copy)void (^finishlock)(NSString *str);
@property(nonatomic,strong)NSDictionary *dictData;
@end