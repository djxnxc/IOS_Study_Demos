//
//  DJStepper.m
//  数量加减按钮
//
//  Created by 12 on 2018/3/7.
//  Copyright © 2018年 DJX. All rights reserved.
//

#import "DJStepper.h"
#define imageFromBundle(imageName) [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"DJStepper.bundle"] ]pathForResource:imageName ofType:@".png"]]
@interface DJStepper()<UITextFieldDelegate>
{
    NSInteger _number;
    UITextField *_textField;
    UIButton *_subBtn;//减
    UIButton *_addBtn;//加

}
@end
@implementation DJStepper
+(DJStepper *)initViewWithFrame:(CGRect)frame{
    DJStepper *stepper = [[DJStepper alloc] init];
    stepper.frame = frame;
    [stepper initView];
    return stepper;
}
//Button+Label
-(void)initView{

    _number = 1;
    //加
    _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _subBtn.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    _subBtn.tag = 1000;
    [_subBtn addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setBut:_subBtn withImage:imageFromBundle(@"decrease2@2x") withHightImage:imageFromBundle(@"decrease2@2x")];

    //label
   _textField = [[UITextField alloc]initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width-self.frame.size.height-self.frame.size.height, self.frame.size.height)];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.font = [UIFont systemFontOfSize:12.0f];
    _textField.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    _textField.text = @"1";
    _textField.delegate = self;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    //减
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(self.frame.size.width-self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    _addBtn.tag = 1001;
    [self setBut:_addBtn withImage:imageFromBundle(@"increase@2x") withHightImage:imageFromBundle(@"increase2@2x")];

    [_addBtn addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addBorder:self];
    [self addBorder:_addBtn];
    [self addBorder:_subBtn];
    [self addSubview:_addBtn];
    [self addSubview:_textField];
    [self addSubview:_subBtn];

}
-(void)addBorder:(UIView *)view{
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1].CGColor;
    view.layer.masksToBounds = YES;
}
-(void)butClick:(UIButton *)btn{
    if (btn.tag==1001) {
        //加
        _number++;
        [_subBtn setImage:imageFromBundle(@"decrease@2x") forState:UIControlStateNormal];
    }else{
        //减
        if (_number>1) {
            _number--;

        }
        if (_number==1)
        {
            [_subBtn setImage:imageFromBundle(@"decrease2@2x") forState:UIControlStateNormal];
        }
    }
    _textField.text = [NSString stringWithFormat:@"%ld",_number];
}
-(void)setBut:(UIButton *)btn withImage:(UIImage *)bgImage withHightImage:(UIImage *)hightImage{
    [btn setImage:bgImage forState:UIControlStateNormal];
    [btn setImage:hightImage forState:UIControlStateHighlighted];
}
#pragma mark - UITextField代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
