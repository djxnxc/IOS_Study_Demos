//
//  ZendaiPasswordGestureViewController.h
//  ZendaiWallet
//
//  Created by ios on 14/12/10.
//  Copyright (c) 2014年 Zendai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSFPasswordGestureView.h"
#import "Tool.h"

//#import "ZendaiHeadImageView.h"

@interface PasswordGestureViewController : UIViewController<SSFPasswordGestureViewDelegate,HZMAPIManagerDelegate>

@property (nonatomic,retain) SSFPasswordGestureView *passwordGestureView;

@property (nonatomic) SSFPasswordGestureViewState state;
/** 21 创建手势密码 22：修改手势密码 23：修改手势密码*/
@property (nonatomic, assign) NSInteger  isfrom;

@property (weak, nonatomic) IBOutlet UILabel *labeltop;
@property (weak, nonatomic) IBOutlet UIView *smallView;

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@property (weak, nonatomic) IBOutlet UIView *gestureContainView;

@property (weak, nonatomic) IBOutlet UIView *boomView;
- (IBAction)loseClicked;
- (IBAction)otherClicked;


@end
