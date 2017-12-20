//
//  MMPPaymentDetailsView.m
//  MMPay
//
//  Created by 12 on 2017/12/20.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MMPPaymentDetailsView.h"

@implementation MMPPaymentDetailsView
+(instancetype)initPaymentDetailsViewWithFrame:(CGRect)frame superView:(UIView *)superView{
    MMPPaymentDetailsView *view = [[NSBundle mainBundle]loadNibNamed:@"MMPPaymentDetailsView" owner:self options:nil].lastObject;
    view.frame = frame;
    view.payNowBut.layer.cornerRadius =4;
    view.payNowBut.layer.masksToBounds = YES;
    view.bgViewHeight.constant =MMP_ScreenH<667?400:MMP_ScreenH/667*431;
    view.amountLabelTop.constant = view.bgViewHeight.constant/431*112;
    [view fadeIn];
    [superView addSubview:view];
    return view;
}
//显示
- (void)fadeIn
{
    self.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1;
        
    }];
}
//消失
- (void)fadeOut
{
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.payBlock = nil;
            [self removeFromSuperview];
        }
    }];
}
- (IBAction)payNowButClick:(UIButton *)sender {
    //收起
    if (self.payBlock) {
        self.payBlock(@"pay");
    }
}
- (IBAction)backButClick:(UIButton *)sender {
    //收起
    if (self.backBlock) {
        [self removeFromSuperview];
        self.backBlock(@"back");
        self.backBlock = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
