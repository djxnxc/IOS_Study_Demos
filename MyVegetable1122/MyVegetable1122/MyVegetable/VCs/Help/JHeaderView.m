//
//  JHeaderView.m
//  QQ好友页面
//
//  Created by 蒋孝才 on 15/7/23.
//  Copyright (c) 2015年 JXC. All rights reserved.
//

#import "JHeaderView.h"
#import "JfriendGroupModel.h"
#define jPadding 10
@interface JHeaderView()
@property (nonatomic, weak) UIButton *icon;
@property (nonatomic, weak) UIButton *nameView;
@property (nonatomic, weak) UIView *v;
@end
@implementation JHeaderView

/**
 某个控件出不来:
 1.frame的尺寸和位置对不对
 
 2.hidden是否为YES
 
 3.有没有添加到父控件中
 
 4.alpha 是否 < 0.01
 
 5.被其他控件挡住了
 
 6.父控件的前面5个情况
 */

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"CHANGJIANWENTIheaderView";
    JHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!headerView) {
        headerView = [[JHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

#pragma mark init方法
/**
 重写init方法，并植入子控件。注意：：：：
 在init方法里面，frame和bounds都是空的，没有赋值
 */
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    // 父控制器使用init方法初始化成功，并且成功赋给本控制器
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加子控件
        // 1.添加按钮
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
        // 背景图片
//        [nameView setBackgroundImage:[UIImage imageNamed:@"cellBG1"] forState:UIControlStateNormal];
//        [nameView setBackgroundImage:[UIImage imageNamed:@"cellBG1"] forState:UIControlStateHighlighted];
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置按钮的内容左对齐
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的内边距
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, jPadding, 0, 0);
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, jPadding, 0, 0);
        [self.contentView addSubview:nameView];
        [nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];
        nameView.backgroundColor = [UIColor whiteColor];
        
        
        self.nameView = nameView;
        
        //右侧icon
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置按钮内部的左边箭头图片
        [b setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        // 设置图片不剪切
        nameView.imageView.clipsToBounds = NO;
        b.imageEdgeInsets = UIEdgeInsetsMake(15,10, 15, 10);
        // 设置图片填充模式为居中：
        nameView.imageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:b];
        self.icon = b;
//        // 2.添加底部细线
        UIView *countView = [[UIView alloc] init];
        countView.backgroundColor = [UIColor lightGrayColor];
        countView.alpha = 0.4;
        self.v = countView;
        [self.contentView addSubview:_v];
        
    }
    return self;
}

#pragma mark 设置frame
/**
  当一个控件的frame发生改变的时候就会调用
  一般在这里布局内部的子控件(设置子控件的frame)
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置按钮的frame
    self.nameView.frame = self.bounds;
    // 设置好友数的frame
    self.icon.frame = CGRectMake(self.frame.size.width - 10-50, 0, 40, self.frame.size.height);
    self.v.frame = CGRectMake(0, self.frame.size.height-0.6, self.frame.size.width, 0.6);
}
#pragma mark model重设
- (void)setGroups:(JfriendGroupModel *)groups{
    _groups = groups;
    // 1.设置数据：组名
    [self.nameView setTitle:groups.name forState:UIControlStateNormal];
//    // 2.设置数据：好友数（在线/总数）
//    self.countView.text = [NSString stringWithFormat:@"%@/%ld",groups.online,groups.friends.count];
    // 3.设置状态：重新设置左边箭头的状态
    [self didMoveToSuperview];
}

#pragma mark 点击方法
/** 监听组名按钮的点击
 */
- (void)nameViewClick
{
    // 1.修改组模型的标记(状态取反)
    self.groups.expand = ! self.groups.isExpand;
    
    // 2.刷新表格
    /**每一次刷新，都会重新加载数据，所以以前被刷掉，因此用添加控件的方法*/
    
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickedNameView:)]) {
        [self.delegate headerViewDidClickedNameView:self];
    }
}

/**
 *  当一个控件被添加到父控件中就会调用
 */
/**每一次刷新，都会重新加载数据，所以以前被刷掉，因此用添加控件的方法*/
- (void)didMoveToSuperview
{
    if (self.groups.expand) {
        self.icon.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        self.icon.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

/**
 *  当一个控件即将被添加到父控件中会调用
 */
- (void)willMoveToSuperview:(UIView *)newSuperview
{

}

@end
