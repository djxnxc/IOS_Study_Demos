//
//  JMessageFrameModel.m
//  QQ聊天布局
//
//  Created by 蒋孝才 on 15/7/18.
//  Copyright (c) 2015年 JXC. All rights reserved.
//

#import "JMessageFrameModel.h"

#import "JMessageModel.h"
#import "NSString+Extension.h"

@implementation JMessageFrameModel

- (void)setMessageModel:(JMessageModel *)messageModel{
    //model数据中转，回头通过fram传给cell-view.
    _messageModel = messageModel;
    
    // 1、标题
    if (messageModel.title) {//有标题
        _TitleFrame = CGRectMake(10, 5, JSCREEN_W-20, 20);
        // 文字计算的最大尺寸：(指定宽度但是不指定高度)
        CGSize textMaxSize = CGSizeMake(JSCREEN_W-20, MAXFLOAT);
        // 文字计算出来的真实尺寸：(按钮内部的label的尺寸)
        CGSize textRealSize = [messageModel.text sizeWithFont:JFont(fontSmall) maxSize:textMaxSize];
        _textFrame = (CGRect){{10, CGRectGetMaxY(_TitleFrame)+5}, textRealSize};
        _cellHeight = CGRectGetMaxY(_textFrame)+15;
        _boom = CGRectMake(0, CGRectGetMaxY(_textFrame)+5, JSCREEN_W,10);
        _CELLFrame = CGRectMake(0, 0, JSCREEN_W,_cellHeight-10);
    }else { //没有标题
        CGSize textMaxSize = CGSizeMake(JSCREEN_W-20, MAXFLOAT);
        // 文字计算出来的真实尺寸：(按钮内部的label的尺寸)
        CGSize textRealSize = [messageModel.text sizeWithFont:JFont(fontSmall) maxSize:textMaxSize];
        _textFrame = (CGRect){{10, 5}, textRealSize};
        _cellHeight = CGRectGetMaxY(_textFrame)+5;
        _boom = CGRectMake(0, CGRectGetMaxY(_textFrame)+5, JSCREEN_W,10);
    }
    
}














@end
