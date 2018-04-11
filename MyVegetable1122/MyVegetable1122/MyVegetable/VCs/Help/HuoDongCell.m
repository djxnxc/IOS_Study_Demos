//
//  HuoDongView.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "HuoDongCell.h"
#import "HuoDongModel.h"
@implementation HuoDongCell
- (void)awakeFromNib {
}
+ (void)initWithModel:(HuoDongModel *)model{
    
}
- (void)setHdmodel:(HuoDongModel *)hdmodel {
    
    if (hdmodel) {
        self.topic.text=hdmodel.isNew;
        [self.bgImage setImageWithURL:hdmodel.num placeholderImage:nil];
        
    }
}


@end
