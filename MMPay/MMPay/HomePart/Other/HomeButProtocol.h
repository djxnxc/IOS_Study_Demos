//
//  HomeButProtocol.h
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeButProtocol <NSObject>
/**
 * HomeVC中按钮的点击事件
 */
-(void)homeVCButClick:(UIButton *)sender;
@end
