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
#define MMP_CUSTOM_COLOR(R,G,B,A)  [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#define MMP_NAV_STATESBAR_HEIGHT (MMP_iPhoneX ? 44:20)
#define MMP_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define MMP_NAV_HEIGHT 44
#define MMP_ScreenW [UIScreen mainScreen].bounds.size.width
#define MMP_ScreenH [UIScreen mainScreen].bounds.size.height

#define MMP_BLUECOLOR MMP_CUSTOM_COLOR(56,150,254,1)
//图片
#define MMP_IMAGE(imageName) [UIImage imageNamed:imageName]
#endif /* MMPHeader_h */
