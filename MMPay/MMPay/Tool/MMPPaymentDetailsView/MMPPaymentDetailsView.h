//
//  MMPPaymentDetailsView.h
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MMPblock)(NSString *str);

@interface MMPPaymentDetailsView : UIView
@property (weak, nonatomic) IBOutlet UIButton *payNowBut;//支付按钮
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;//转账金额
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountLabelTop;//转账金额上间距
@property(nonatomic,copy)MMPblock payBlock;
@property(nonatomic,copy)MMPblock backBlock;


+(instancetype)initPaymentDetailsViewWithFrame:(CGRect)frame superView:(UIView *)superView;

@end
