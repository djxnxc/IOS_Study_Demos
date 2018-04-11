//
//  DingqiLICAI.m
//  LTInfiniteScrollView
//
//  Created by mythkiven on 15/11/16.
//  Copyright © 2015年 ltebean. All rights reserved.
//

#import "DingqiLICAI.h"
#import "DingLICAIModel.h"
#import "BuyModel.h"
@implementation DingqiLICAI

- (IBAction)clickedBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickedDetailBtnn:)]) {
        [self.delegate didClickedDetailBtnn:sender];
    }
}

+(instancetype)viewWith:(NSString *)str {
  
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    // 读取xib文件(会创建xib中的描述的所有对象,并且按顺序放到数组中返回)
    NSArray *objs = [bundle loadNibNamed:@"DingqiLICAI" owner:nil options:nil];
    DingqiLICAI *appView = [objs lastObject];
    appView.layer.cornerRadius = appView.bounds.size.width/2;
    appView.layer.masksToBounds = YES;
    appView.str = str;
    return appView;
    
    
}
- (void)setDmodel:(DingLICAIModel *)dmodel {
    
    
    self.backgroundColor = [UIColor clearColor];
    
    
    
    //判读是否显示最后一个view
    if ([dmodel.smallTitle isEqualToString:@"Null"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    //显示两侧的数据
    if (dmodel.smallTitle.length) {
        self.lastLabel.hidden= NO;
        self.lastImg.hidden = NO;
        self.bg.hidden = YES;
        self.lastLabel.text = dmodel.smallTitle;
        self.nianhuaLabel.text = @"";
        self.per.text = @"";
        [self.chanpinBtn setTitle:@"" forState:UIControlStateNormal];
    }else{
        
        self.lastLabel.hidden = YES;
        self.lastImg.hidden = YES;
        self.bg.hidden = NO;
        self.nianhuaLabel.text = @"年化收益率";
        [self.chanpinBtn setTitle:@"产品详情" forState:UIControlStateNormal];
        
//        self.per.text = dmodel.title;
        BuyModel *model =dmodel.model;
        if ([dmodel.model isKindOfClass:[DingLICAIModel class]]) {
            DingLICAIModel *mmm = dmodel.model;
            model= mmm.model;
        }else{
            model = dmodel.model;
        }
        if (dmodel.model) {
#warning 判断显示
            if (model.minRate) {
                NSString *min = [NSString stringWithFormat:@"%.2lf",model.minRate];
                min = [min stringByAppendingString:@"%"];
                NSString *max = [NSString stringWithFormat:@"%.2lf",model.maxRate];
                max = [max stringByAppendingString:@"%"];
                self.per.text=[NSString stringWithFormat:@"%@~%@",min,max];
                int a = (int)self.per.text.length;
                a--;
                NSRange r1 = [min rangeOfString:@"."];
                NSString *rs1 = [min substringToIndex:r1.location];
                NSRange r2 = [max rangeOfString:@"."];
                NSString *rs2 = [max substringToIndex:r2.location];
                [self setFontColorLabel:self.per :0 :rs1.length];
                [self setFontColorLabel:self.per :a-max.length+1 :rs2.length];
            }else{
                NSString *max = [NSString stringWithFormat:@"%.2lf",model.maxRate];
                max = [max stringByAppendingString:@"%"];
                self.per.text=[NSString stringWithFormat:@"%@",max];
                int a = (int)self.per.text.length;
                a--;
                [self setFontColorLabel:self.per :0 :1];
            }
            
        }
    }
//    if (dmodel.title.length) {
//        self.per.text = dmodel.title;
//        int a = (int)self.per.text.length;
//        a--;
//        [self setFontColorLabel:self.per :0 :1];
//    }
    
    
    [self.bg setImage:[UIImage imageNamed:dmodel.icon]];
    [self.lastImg setImage:[UIImage imageNamed:dmodel.icon]];
    
    
}
- (void)setStr:(NSString *)str {
    self.per.text = str;
    self.lastLabel.hidden= YES;
//    [self setFontColorLabel:self.per :0 :(int)str.length-1];
}

-(void)setFontColorLabel:(UILabel *)label :(int)a :(int)b {
    if (a<0|b<0) {
        return;
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:label.attributedText];
    [att addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(a, b)];
    //    [att addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSUnderlineColorAttributeName:RGB_red} range:NSMakeRange(a, b)];
    label.attributedText = att;
}

- (void)layoutSubviews {
    [self.bg setImage:[UIImage imageNamed:@"financing_huoqi_bg.png"]];
//    [self setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"financing_huoqi_bg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
}
@end
