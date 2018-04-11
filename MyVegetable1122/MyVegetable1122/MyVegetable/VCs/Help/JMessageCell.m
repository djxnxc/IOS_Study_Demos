//
//  JMessageCell.m
//  QQ聊天布局
//
//  Created by 蒋孝才 on 15/7/18.
//  Copyright (c) 2015年 JXC. All rights reserved.
//

#import "JMessageCell.h"
//用于传入计算好的frame属性
#import "JMessageFrameModel.h"
//用于model赋数据
#import "JMessageModel.h"
//提供图形的不拉伸方法
#import "UIImage+Extension.h"


@interface JMessageCell()
{
    UIImageView *V;
}
/**  时间*/
@property (nonatomic, strong) UILabel     *timeLabel;
/**  头像*/
@property (nonatomic, strong) UIImageView *iconIV;
/**  正文*/
@property (nonatomic, strong) UILabel    *textBtn;
@property (nonatomic, strong) UIView   *boom;
@end

@implementation JMessageCell

#pragma mark cell的初始化：
+ (instancetype)cellWithTableView:(UITableView *)tableView isChange:(BOOL)is{
    static NSString *ID = @"ID";
    JMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[JMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID isChange:is];
    }
    return cell;
    
}

//#pragma mark 重写系统的方法：
///
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isChange:(BOOL)is
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (is) {
            self.boom.backgroundColor = [UIColor whiteColor];
            self.contentView.backgroundColor = [UIColor whiteColor];
            V = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBG1"]];
            //            V.frame = self.contentView.frame;
            [self.contentView addSubview:V];
            self.isChange =99;
        }
        
        
        //子控件的创建于初始化：(先初始化固定的内容)
        // 1标题
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = RGB_red;
        timeLabel.font = JFont(fontMid);
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 2.正文
        UILabel *textView = [[UILabel alloc] init];
        textView.numberOfLines = 0; // 自动换行
        textView.font = JFont(fontSmall);
//        textView.contentEdgeInsets = UIEdgeInsetsMake(jTextPadding, jTextPadding, jTextPadding, jTextPadding);//正文的内边距
        textView.textColor = [UIColor blackColor];
        [self.contentView addSubview:textView];
        self.textBtn = textView;
        
        self.boom = [[UIView alloc] init];
        self.boom.backgroundColor = RGB_gray;
        
        [self.contentView addSubview:self.boom];
        // 4.设置cell的背景色
        self.contentView.backgroundColor = RGB_gray;
        
       
//        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
    
}

#pragma mark 设置数据模型
/**从frame作为中转，并计算了frame，同时中转model*/
- (void)setMessageFrame:(JMessageFrameModel *)messageFrame{
   
    _messageFrame = messageFrame;//接受frame
    JMessageModel *messageModel = messageFrame.messageModel;//中转的model传入
    
    // 1、时间
    if (messageModel.title) {
        _timeLabel.frame = messageFrame.TitleFrame;
        _timeLabel.text = messageModel.title;
    }
    _textBtn.text =messageModel.text;
    _textBtn.frame = messageFrame.textFrame;
    _boom.frame = messageFrame.boom;
    
    if (self.isChange == 99) {
        V.frame = messageFrame.CELLFrame;
        self.isChange = 0;
    }
    
}
    
    
    
    
    
    
    
    
    
    




















@end
