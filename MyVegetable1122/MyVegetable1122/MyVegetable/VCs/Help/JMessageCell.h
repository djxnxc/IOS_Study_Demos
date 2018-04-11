//
//  JMessageCell.h
//  QQ聊天布局
//
//  Created by 蒋孝才 on 15/7/18.
//  Copyright (c) 2015年 JXC. All rights reserved.
//


/**
 
 仅用于封装cell里面view的子视图的初始化的方法。
 将模型的填充(涉及到frame的计算等麻烦的事宜)单独放在一个类中来处理，
 这样分工更加明确。
 

 */

#import <UIKit/UIKit.h>
@class JMessageFrameModel;


@interface JMessageCell : UITableViewCell

/**将model数据以及计算好的frame属性传入*/
@property (nonatomic, strong) JMessageFrameModel *messageFrame;
@property (nonatomic, assign) NSInteger  isChange;
/**cell的初始化方法*/
+ (instancetype)cellWithTableView:(UITableView *)tableView isChange:(BOOL)is;

@end
















