//
//  HTQRCodeView.h
//  QRCode
//
//  Created by 邓家祥 on 2018/5/7.
//  Copyright © 2018年 邓家祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTQRCodeView : UIView
/**
 @param frame 二维码视图坐标大小
 @param QRStr 二维码的字符串内容
 */
+(HTQRCodeView *)creatQRCodeViewWithFrame:(CGRect )frame QRStr:(NSString *)QRStr;

@end
