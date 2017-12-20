//
//  MMPPassWordView.m
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MMPPassWordView.h"

@implementation MMPPassWordView
+(instancetype)initPassWordViewWithFrame:(CGRect)frame{
    MMPPassWordView *view = [[MMPPassWordView alloc]init];
    view.frame = frame;
    view.backgroundColor = MMP_CUSTOM_COLOR(0, 0, 0, 0.3);
    UIView *headView = [[UIView alloc]init];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
