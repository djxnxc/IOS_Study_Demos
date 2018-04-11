//
//  JMessageFrameModel.h
//  QQ聊天布局
//
//  Created by 蒋孝才 on 15/7/18.
//  Copyright (c) 2015年 JXC. All rights reserved.
//


/**
 
 将cell里面的数据分为三个模型：
 view用于初始化子控件view,已经执行
 model用于填充数据模型
 frame用于计算属性的尺寸以及所有的cell内容的宏定义等等。
 流程：
 vc在cellview里面先初始化基本的view，
 然后将模型传入frame模型中，对各个子控件的frame进行赋值计算。并进行model的赋值。
 然后到view里面，将frame传入子控件中，同时进行model的赋值。
 
 model中间经过frame中转一次。
 
 

 
 */
#import <UIKit/UIKit.h>
@class JMessageModel;
//宏定义：



@interface JMessageFrameModel : NSObject

/**  标题的frame*/
@property (nonatomic, assign, readonly) CGRect TitleFrame;
/**  正文的frame*/
@property (nonatomic, assign, readonly) CGRect textFrame;
/**  CELL的frame*/
@property (nonatomic, assign, readonly) CGRect CELLFrame;
@property (nonatomic,assign,readonly) CGRect boom;
/**  cell的高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/**  数据模型*/
@property (nonatomic, strong)     JMessageModel *messageModel;
//在frame里面填充模型，以及frame的计算.同时作为中专站，后续传给cell view













@end
