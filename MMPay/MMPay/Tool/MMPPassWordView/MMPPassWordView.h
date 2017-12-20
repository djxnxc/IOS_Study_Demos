//
//  MMPPassWordView.h
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPasswordView.h"
typedef void (^MMPblock)(NSString *str);
@interface MMPPassWordView : UIView
@property(nonatomic,copy)MMPblock block;
@property(nonatomic,copy)MMPblock successBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passWordBgViewHeight;//密码输入框背景的高度
@property (weak, nonatomic) IBOutlet UIView *passWordBgView;//密码输入框白色背景view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordTextFieldHeight;//密码输入框的高度
@property (nonatomic, strong) SYPasswordView *pasView;//第三方带边框密码输入框

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;//密码输入框

+(instancetype)initPassWordViewWithFrame:(CGRect)frame superView:(UIView *)superView;
@end
