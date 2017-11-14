//
//  DJXRefreshTool.h
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJXRefreshTool : NSObject
//文字刷新
+ (void)initWithTableViewRefresh:(UITableView*)tableView andTarget:(id)target andHeaderSelector:(SEL)headerSelector andFooterSelector:(SEL)footerSelector;
//gif刷新
+ (void)initWithTableViewGifRefresh:(UITableView*)tableView andTarget:(id)target andHeaderSelector:(SEL)headerSelector andFooterSelector:(SEL)footerSelector;

@end
