//
//  JHeaderView.h
//  QQ好友页面
//
//  Created by 蒋孝才 on 15/7/23.
//  Copyright (c) 2015年 JXC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JfriendGroupModel,JHeaderView;

@protocol JHeaderViewDelegate <NSObject>
- (void)headerViewDidClickedNameView:(JHeaderView *)headerView;
@end


@interface JHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) JfriendGroupModel *groups;
@property (nonatomic, weak) id<JHeaderViewDelegate> delegate;


@end
