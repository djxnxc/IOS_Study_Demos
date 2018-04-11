//
//  SSFPasswordGestureView.m
//  RecoginizerPasswordDemo
//
//  Created by 施赛峰 on 14-7-22.
//  Copyright (c) 2014年 赛峰 施. All rights reserved.
//

#import "SSFPasswordGestureView.h"
#import "SSFPathLineLayer.h"
#import <math.h>

#define SSFPointRaious 32
#define SSFMinDrawPointsCount 4

@interface SSFPasswordGestureView()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *pointButtons;
@property (strong, nonatomic) NSMutableArray *unselectedButtons;
@property (strong, nonatomic) SSFPathLineLayer *pathLayer;
@property (nonatomic) NSInteger inputCount;
@property (strong, nonatomic) NSString *passwordInProgress;

@end

@implementation SSFPasswordGestureView


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.pathLayer = [SSFPathLineLayer layer];
        self.pathLayer.passwordGestureView = self;
        self.pathLayer.frame = self.bounds;
        [self.layer addSublayer:self.pathLayer];
        self.inputCount = 5;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

}

#pragma mark - panGesture Action

- (IBAction)firstPointButtonPressed:(UIButton *)sender
{
    UIButton *startPointButton = (UIButton *)[self viewWithTag:sender.tag];
//    startPointButton.backgroundColor = [UIColor redColor];
    startPointButton.selected = YES;
    self.startPoint = startPointButton.center;
    self.endPoint = self.startPoint;
}



- (IBAction)panGestureHandle:(UIPanGestureRecognizer *)sender
{
    if (sender.state ==  UIGestureRecognizerStateBegan)
    {
        //所有button变回最初状态
        for (UIButton *button in self.pointButtons) {
            [ button setBackgroundImage:[UIImage imageNamed:@"dayuan"] forState:UIControlStateNormal];
            button.selected = NO;
        }
        
        //属性初始化
        self.selectedButtons = nil;
        self.unselectedButtons = nil;
        
    }
  
    CGPoint newPoint = [sender translationInView:self];
    self.endPoint = CGPointMake(self.endPoint.x + newPoint.x, self.endPoint.y + newPoint.y);
    [self reachButtonWithPoint:self.endPoint];
    [self.pathLayer setNeedsDisplay];
    [sender setTranslation:CGPointMake(0, 0) inView:self];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.selectedButtons.count < SSFMinDrawPointsCount) {
            [self clear];
            ZendaiAlertView *alert=[[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:@"请至少绘制四个点" leftButtonTitle:nil rightButtonTitle:@"确定"];
            __weak ZendaiAlertView *alertt = alert;
            alert.rightBlock = ^(){[alertt removeFromSuperviewi ];};
            [alert show];
            return;
        }
        //绘制完成先保存密码
        NSString *string = [[NSString alloc] init];
        //第一次绘制
        if (self.state == SSFPasswordGestureViewStateWillFirstDraw || self.state == SSFPasswordGestureViewStateFinishWrong) {
            for (int i = 0; i < self.selectedButtons.count; i++) {
                UIButton *button = self.selectedButtons[i];
                string = [string stringByAppendingString:[NSString stringWithFormat:@"%d",(int)button.tag]];
            }
            self.passwordInProgress = string;
            [[NSUserDefaults standardUserDefaults] setObject:string forKey:SSFFirstUserGesturePasswordKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        //第二次绘制
        else if (self.state == SSFPasswordGestureViewStateWillAgainDraw) {
            for (int i = 0; i < self.selectedButtons.count; i++) {
                UIButton *button = self.selectedButtons[i];
                string = [string stringByAppendingString:[NSString stringWithFormat:@"%d",(int)button.tag]];
            }
            self.passwordInProgress = string;
            [[NSUserDefaults standardUserDefaults] setObject:string forKey:SSFSecondUserGesturePasswordKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        //检查匹配手势
        else if (self.state == SSFPasswordGestureViewStateCheck || self.state == SSFPasswordGestureViewStateCheckWrong) {
            for (int i = 0; i < self.selectedButtons.count; i++) {
                UIButton *button = self.selectedButtons[i];
                string = [string stringByAppendingString:[NSString stringWithFormat:@"%d",(int)button.tag]];
            }
            self.passwordInProgress = string;
            [[NSUserDefaults standardUserDefaults] setObject:string forKey:SSFUserINPUTGesturePasswordKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        [self clear];
        
        //状态切换
        //首次
        if (self.state == SSFPasswordGestureViewStateWillFirstDraw || self.state == SSFPasswordGestureViewStateFinishWrong) {
            self.state = SSFPasswordGestureViewStateWillAgainDraw;
        }
        //二次
        else if (self.state == SSFPasswordGestureViewStateWillAgainDraw) {
            if ([self checkFirstAndSecondPassword]) {
                self.state = SSFPasswordGestureViewStateFinishDraw;
            } else {
                self.state = SSFPasswordGestureViewStateFinishWrong;
            }
        }
        //检查
        else if (self.state == SSFPasswordGestureViewStateCheck || self.state == SSFPasswordGestureViewStateCheckWrong) {
            if ([self checkGesturePassword]) {
                self.state = SSFPasswordGestureViewStateCheck;
            } else {
                self.state = SSFPasswordGestureViewStateCheckWrong;
            }
        }
        
        //根据状态来执行不同的操作
        switch (self.state) {
            case SSFPasswordGestureViewStateWillAgainDraw:
                //完成第一次手绘密码，提醒继续第二次手绘
                if ([self.delegate respondsToSelector:@selector(passwordGestureViewFinishFirstTimePassword: andPasswordInProgress:)]) {
                    [self.delegate passwordGestureViewFinishFirstTimePassword:self andPasswordInProgress:self.passwordInProgress];
                }
                break;
            case SSFPasswordGestureViewStateFinishDraw:
            {
                //完成第二次手绘密码,并与第一次密码相同
                NSString * gpd = [[NSUserDefaults standardUserDefaults] objectForKey:SSFSecondUserGesturePasswordKey];
                if (gpd.length) {
                    if ([self.delegate respondsToSelector:@selector(passwordGestureViewFinishSecondTimePassword:andPassword:)]) {
                        [self.delegate passwordGestureViewFinishSecondTimePassword:self andPassword:gpd];
#warning 此处将用户的手势密码进行 ---本地化
                        [[NSUserDefaults standardUserDefaults] setObject:gpd forKey:SSFBDGesturePasswordKey];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                    }
                }
                break;
            }
            case SSFPasswordGestureViewStateFinishWrong:
                //第一次与第二次密码不一样
//                [self wrongPassword:self.passwordInProgress];
                if ([self.delegate respondsToSelector:@selector(passwordGestureViewFinishWrongPassword:andPasswordInProgress:)]) {
                    [self.delegate passwordGestureViewFinishWrongPassword:self andPasswordInProgress:self.passwordInProgress];
                }
                break;
            case SSFPasswordGestureViewStateCheck:
            {
                //check手势密码成功
                if ([self.delegate respondsToSelector:@selector(passwordGestureViewFinishCheckPassword:andPasswordInProgress:)]) {
                    [self.delegate passwordGestureViewFinishCheckPassword:self andPasswordInProgress:self.passwordInProgress];
                }
                break;
            }
            case SSFPasswordGestureViewStateCheckWrong:
                //check手势密码失败
//                 [self wrongPassword:self.passwordInProgress];
                if ([self.delegate respondsToSelector:@selector(passwordGestureViewCheckPasswordWrong:andInputCount:andPasswordInProgress:)]) {
                    --self.inputCount;
                    [self.delegate passwordGestureViewCheckPasswordWrong:self andInputCount:self.inputCount andPasswordInProgress:self.passwordInProgress];
                }
                break;
            default:
                break;
        }
    }
}

- (void)clear
{
    //所有button变回最初状态
    for (UIButton *button in self.pointButtons) {
        [ button setBackgroundImage:[UIImage imageNamed:@"dayuan"] forState:UIControlStateNormal];
        button.selected = NO;
    }
    
    //属性初始化
    self.selectedButtons = nil;
    self.unselectedButtons = nil;
    self.startPoint = CGPointMake(0, 0);
    self.endPoint = CGPointMake(0, 0);
    [self.pathLayer setNeedsDisplay];
}



- (IBAction)firstPointButtonTouchUpInside:(UIButton *)sender
{
    sender.selected = NO;
//    if (!self.selectedButtons.count) {
//        sender.backgroundColor = [UIColor blackColor];
//    }
}

#pragma mark - methods

- (void)reachButtonWithPoint:(CGPoint)point
{
    
    UIButton *lastBtn=(UIButton *)self.selectedButtons.lastObject;
    for (UIButton * button in self.unselectedButtons) {
        CGPoint buttonPoint = button.center;
        CGFloat distance = sqrtf(powf(fabsf(point.x - buttonPoint.x) , 2) + powf(fabsf(point.y - buttonPoint.y) , 2));
        if (distance <= SSFPointRaious) {
            if (((button.tag==1||button.tag==3||button.tag==7||button.tag==9)&&(lastBtn.tag==1||lastBtn.tag==3||lastBtn.tag==7||lastBtn.tag==9))||(button.tag+lastBtn.tag==10)) {
                
                UIButton *midBtn=(UIButton *)[self viewWithTag:(button.tag+lastBtn.tag)/2];
                
                midBtn.selected = YES;
                [self.unselectedButtons removeObject:midBtn];
                [self.selectedButtons addObject:midBtn];//完成一次绘制后要清空
                
            }
            
             button.selected = YES;
            [self.unselectedButtons removeObject:button];
            [self.selectedButtons addObject:button];//完成一次绘制后要清空
            break;
        }
    }
}

-(void)wrongPassword:(NSString *)password
{
    self.pathLayer.isWrong=YES;
    
    for (int i=0; i<password.length; i++) {
        
        NSRange range=NSMakeRange(i, 1);
        NSString *str=[password substringWithRange:range];
        UIButton *btn=(UIButton *)[self viewWithTag:[str intValue]];
       [ btn setBackgroundImage:[UIImage imageNamed:@"dayuan_xuan"] forState:UIControlStateNormal];
        
        [self.selectedButtons addObject:btn];
    }
    self.startPoint=((UIButton *)self.selectedButtons[0]).center;
    self.endPoint=((UIButton *)self.selectedButtons.lastObject).center;
    
    [self.pathLayer setNeedsDisplay];
    
}


- (BOOL)checkFirstAndSecondPassword
{
    NSString *password1 = [[NSUserDefaults standardUserDefaults] objectForKey:SSFFirstUserGesturePasswordKey];
    NSString *password2 = [[NSUserDefaults standardUserDefaults] objectForKey:SSFSecondUserGesturePasswordKey];
    if ([password1 isEqualToString:password2]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
        return YES;
    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码设置有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
        return NO;
    }
}

- (BOOL)checkGesturePassword
{
    NSString *checkPassword = [[NSUserDefaults standardUserDefaults] objectForKey:SSFUserINPUTGesturePasswordKey];
    NSString *savePassword = [[NSUserDefaults standardUserDefaults] objectForKey:SSFBDGesturePasswordKey];
    if ([checkPassword isEqualToString:savePassword]) {
        return YES;//匹配本地密码
    }
    
    if (self.gesturePassword) {
        
        
        if ([self.gesturePassword isEqualToString:checkPassword]) {
            return YES;
        }else {
           return NO;
        }
    } else
    {return NO;}
}

#pragma mark - properties

- (void)setPointButtons:(NSArray *)pointButtons
{
    _pointButtons = pointButtons;
    for (UIButton *button in _pointButtons) {
        button.layer.cornerRadius = 30.0;
    }
    self.unselectedButtons = [_pointButtons mutableCopy];
}

- (NSMutableArray *)selectedButtons
{
    if (!_selectedButtons) {
        _selectedButtons = [[NSMutableArray alloc] init];
    }
    return _selectedButtons;
}

- (NSMutableArray *)unselectedButtons
{
    if (!_unselectedButtons) {
        _unselectedButtons = [self.pointButtons mutableCopy];
    }
    return _unselectedButtons;
}

#pragma mark - instance method

+ (SSFPasswordGestureView *)instancePasswordView
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"SSFPasswordGestureView" owner:self options:nil];
    return arr[0];
}

@end
