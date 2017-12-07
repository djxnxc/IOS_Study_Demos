//
//  DJXRefreshTool.m
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "DJXRefreshTool.h"

@implementation DJXRefreshTool
+ (void)initWithTableViewRefresh:(UITableView*)tableView andTarget:(id)target andHeaderSelector:(SEL)headerSelector andFooterSelector:(SEL)footerSelector
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    if (headerSelector) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerSelector];
        // 设置刷新控件
        tableView.mj_header = header;
    }
    
    
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    if (footerSelector) {
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:footerSelector];
        
        // 设置footer
        tableView.mj_footer = footer;
    }
}
+ (void)initWithTableViewGifRefresh:(UITableView*)tableView andTarget:(id)target andHeaderSelector:(SEL)headerSelector andFooterSelector:(SEL)footerSelector
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    if (headerSelector) {
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:headerSelector];
        CGRect frame = tableView.mj_header.frame;
        header.frame = frame;
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i <= 8; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%d.tiff",i];
            UIImage *image =[UIImage imageNamed:imageName];
            [images addObject:image];
        }
        //1.设置普通状态的动画图片
        [header setImages:images forState:MJRefreshStateIdle];
//        //2.设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:images forState:MJRefreshStatePulling];
//        //3.设置正在刷新状态的动画图片
        [header setImages:images forState:MJRefreshStateRefreshing];
        // 设置刷新控件
        header.lastUpdatedTimeLabel.hidden=YES;
        header.stateLabel.hidden=YES;
        tableView.mj_header = header;
    }
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    if (footerSelector) {
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:footerSelector];
        
        // 设置footer
        tableView.mj_footer = footer;
    }
}
@end
