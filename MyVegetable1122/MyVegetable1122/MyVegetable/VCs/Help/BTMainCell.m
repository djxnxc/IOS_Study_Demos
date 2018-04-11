//
//  BTMainCell.m
//  qiuquan
//
//  Created by mythkiven on 15/11/9.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "BTMainCell.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "MainModel.h"
@interface BTMainCell ()

@property (weak, nonatomic) IBOutlet UIView *zongView;
//左
@property (weak, nonatomic) IBOutlet UIImageView *leftReXiao;
@property (weak, nonatomic) IBOutlet UIImageView *leftQuan;
//套装
@property (weak, nonatomic) IBOutlet UILabel *daijinquan;
@property (weak, nonatomic) IBOutlet UILabel *jizhang;
//价格
@property (weak, nonatomic) IBOutlet UILabel *jiage;
@property (weak, nonatomic) IBOutlet UILabel *yuanjia;
@property (weak, nonatomic) IBOutlet UILabel *yishou;
//优惠
@property (weak, nonatomic) IBOutlet UILabel *hui;
@property (weak, nonatomic) IBOutlet UILabel *youhui;
//使用条件
@property (weak, nonatomic) IBOutlet UILabel *man;
@property (weak, nonatomic) IBOutlet UILabel *tiaojian;

@end
@implementation BTMainCell
- (void)awakeFromNib {
    
    self.zongView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.zongView.layer.borderWidth = 0.5;
    
    
    self.jizhang.layer.cornerRadius = 0;
    self.jizhang.layer.masksToBounds = YES;
    self.jizhang.layer.borderColor = self.jizhang.textColor.CGColor;
    self.jizhang.layer.borderWidth = 0.5;
    
}

- (void)setModel:(MainModel *)model{

//    self.model = model;
//    设置新品热销
    if ([model.isNew intValue]== 0) {//热销
        [self.leftReXiao setImage:[UIImage imageNamed:@"rexiao"]];
    }else if ([model.isNew intValue]== 1){//新品
        [self.leftReXiao setImage:[UIImage imageNamed:@"xinpin"]];
    }
//    设置球券图片
    [self.leftQuan sd_setImageWithURL:[NSURL URLWithString:model.imageString] placeholderImage:[UIImage imageNamed:@"moren"]];
    
//    是否套装
    if (([model.isMore intValue] == 1)&&([model.num intValue]>=2)) {
        self.jizhang.hidden = NO;
        self.daijinquan.hidden = NO;
        self.jizhang.text = [NSString  stringWithFormat:@"%@张",model.num];
    }else{
        self.jizhang.hidden = YES;
        self.daijinquan.hidden = YES;
    }
//    价格
    self.jiage.text = [NSString stringWithFormat:@"￥%@",model.nowPrice];
    self.yuanjia.text = [NSString stringWithFormat:@"￥%@",model.beforePrice];
    self.yishou.text = [NSString stringWithFormat:@"已售%@",model.saleNum];
//    优惠
    if (model.cheapString) {
        self.youhui.text = [NSString stringWithFormat:@"优惠:%@",model.cheapString];
    }
    if (model.tiaojianString) {
        self.tiaojian.text = [NSString stringWithFormat:@"使用条件:%@",model.tiaojianString];
    }
}
@end
