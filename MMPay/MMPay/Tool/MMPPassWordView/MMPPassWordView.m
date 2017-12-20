//
//  MMPPassWordView.m
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MMPPassWordView.h"
@implementation MMPPassWordView
+(instancetype)initPassWordViewWithFrame:(CGRect)frame superView:(UIView *)superView{
    MMPPassWordView *view = [[NSBundle mainBundle]loadNibNamed:@"MMPPassWordView" owner:self options:nil].lastObject;
    view.frame = frame;
    view.passWordBgViewHeight.constant =MMP_ScreenH<667?400:MMP_ScreenH/667*431;
    view.passwordTextFieldHeight.constant =MMP_ScreenW/375*45;
    [view fadeIn];
    view.pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(view.passWordTextField.frame.origin.x, view.passWordTextField.frame.origin.y, MMP_ScreenW-30,MMP_ScreenW/375*45)];
    __weak typeof(view) weakView = view;
    view.pasView.successBlock = ^(NSString *str) {
        __strong typeof(weakView) strongView = weakView;
        if (strongView.successBlock) {
            [strongView removeFromSuperview];
            strongView.successBlock(@"success");
        }
    };
    [view.passWordBgView addSubview:view.pasView];
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
            self.block = nil;
            [self removeFromSuperview];
        }
    }];
}
- (IBAction)backButClick:(UIButton *)sender {
    //收起
    if (self.block) {
        [self removeFromSuperview];
        self.block(@"back");
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
