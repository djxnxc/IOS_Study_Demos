//
//  SelectCityDialog.m
//  MyVegetable
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "SelectCityDialog.h"

@implementation SelectCityDialog
@synthesize selectDelegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithNib
{
    NSArray* arr=[[NSBundle mainBundle]loadNibNamed:@"selectCityDialog" owner:self options:nil];
    self=[arr firstObject];
    if (self) {
        windows=[UIApplication sharedApplication].keyWindow;
        backView=[[UIView alloc]initWithFrame:windows.frame];
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [backView addGestureRecognizer:tap];
        backView.backgroundColor=[UIColor blackColor];
        backView.alpha=0.6;

    }
    return self;
}
-(void)show
{
    self.cityPickerView.dataSource=self;
    self.cityPickerView.delegate=self;
    [windows addSubview:backView];
    self.frame=CGRectMake(0, windows.frame.size.height+2, windows.frame.size.width, 260);
    [windows addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, windows.frame.size.height-259, windows.frame.size.width, 260);
    }];
}
-(void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, windows.frame.size.height+2, windows.frame.size.width, 260);
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
- (IBAction)cancleBtn:(id)sender {
    [self dismiss];
}

- (IBAction)shure:(id)sender {
    if (self.citys) {
        
    [self.selectDelegate selectCityIndex:self atIndex:[self.cityPickerView selectedRowInComponent:0]];
    }
    [self dismiss];
}
#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.citys.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.citys objectAtIndex:row];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}
@end
