//
//  PopView.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "PopView.h"
@interface PopView()
@property (strong, nonatomic) UIView    *bg1;
@property (strong, nonatomic) UIView    *popView1;
@property (strong, nonatomic) UILabel   *title1;
@property (strong, nonatomic) UIView    *fengeView1;
@property (strong, nonatomic) UIButton  *cancel1;
@property (strong, nonatomic) UIButton  *sure1;
@property (strong, nonatomic) UIButton  *dismiss1;
@property (strong, nonatomic) UILabel   *detail1;
@end
@implementation PopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    
    if (self) {
        self.bg1.backgroundColor = [UIColor blackColor];
        self.bg1.alpha = 0.2;
        self.bg1.frame = self.frame;
//        self.popView.layer.cornerRadius = 10;
//        self.popView.layer.masksToBounds = YES;
//        self.cancel.layer.cornerRadius = 8;
//        self.cancel.layer.masksToBounds = YES;
//        self.sure.layer.cornerRadius = 8;
//        self.sure.layer.masksToBounds = YES;
    }
    return self;
}

- (IBAction)cancelBtn {
    if ([self.delegate respondsToSelector:@selector(cancel)]) {
        [self.delegate cancel];
    }
}

- (IBAction)sureBtn {
    if ([self.delegate respondsToSelector:@selector(sure)]) {
        [self.delegate sure];
    }
}

- (IBAction)dismissBtn {
    if ([self.delegate respondsToSelector:@selector(dismiss)]) {
        [self.delegate dismiss];
    }
}
@end
