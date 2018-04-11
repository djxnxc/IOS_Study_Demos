//
//  InputDialog.m
//  FootballReferee
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 com.yunhoo.www. All rights reserved.
//

#import "InputDialog.h"

@implementation InputDialog
@synthesize inputDelegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithNib
{
    NSArray* arr=[[NSBundle mainBundle]loadNibNamed:@"inputDialog" owner:self options:nil];
    self=[arr firstObject];
    if (self) {
        [self.layer setCornerRadius:5];
        [self.shureBtn.layer setCornerRadius:5];
        [self.layer setMasksToBounds:YES];
        [self.shureBtn.layer setMasksToBounds:YES];
        windows=[UIApplication sharedApplication].keyWindow;
        backView=[[UIView alloc]initWithFrame:windows.frame];
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismess)];
        [backView addGestureRecognizer:tap];
        backView.backgroundColor=[UIColor blackColor];
        backView.alpha=0.6;

    }
    return self;
}
-(void)dismess
{
    [backView removeFromSuperview];
    [self removeFromSuperview];
    
}
-(void)show
{
    [windows addSubview:backView];
    self.frame=CGRectMake(0, 0, 250, 150);
    self.center=backView.center;
    [windows addSubview:self];
}

- (IBAction)cancle:(id)sender {
    [self dismess];
}
- (IBAction)shure:(id)sender {
    [self.inputDelegate inputMessage:self theMessage:self.inputMessage.text];
    [self dismess];
}
@end
