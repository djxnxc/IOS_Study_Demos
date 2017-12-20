//
//  MMPHeader.h
//  MMPay
//
//  Created by 12 on 2017/12/6.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#ifndef MMPHeader_h
#define MMPHeader_h
/********宏定义***********/
#define MMP_CUSTOM_COLOR(R,G,B,A)  [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]//颜色值
#define MMP_NAV_STATESBAR_HEIGHT (MMP_iPhoneX ? 44:20)//导航栏的状态栏高度
#define MMP_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)//判断是否是iPhone X

#define MMP_NAV_HEIGHT 44 //导航栏高度
#define MMP_ScreenW [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define MMP_ScreenH [UIScreen mainScreen].bounds.size.height//屏幕高度

#define MMP_BLUECOLOR MMP_CUSTOM_COLOR(57,150,254,1)//主题颜色
#define MMP_BackgroundColor MMP_CUSTOM_COLOR(250,249,249,1)//灰色背景颜色
#define MMP_GrayLineColor MMP_CUSTOM_COLOR(242,242,245,1)//列表分割线颜色
#define MMP_IMAGE(imageName) [UIImage imageNamed:imageName]//图片宏

#define MMP_ALERT(title,msg) [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil]//消息弹窗
#define  MMP_ALERT_SHOW(title,msg) [MMP_ALERT(title,msg) show]
#endif /* MMPHeader_h */
