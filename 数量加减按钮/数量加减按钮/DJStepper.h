//
//  DJStepper.h
//  数量加减按钮
//
//  Created by 12 on 2018/3/7.
//  Copyright © 2018年 DJX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJStepper : UIView
+(DJStepper *)initViewWithFrame:(CGRect)frame;
@property(nonatomic,copy)void (^backBlock)(NSString *number);
@end
