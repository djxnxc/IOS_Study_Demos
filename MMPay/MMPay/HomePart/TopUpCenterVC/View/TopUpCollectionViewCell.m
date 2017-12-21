//
//  TopUpCollectionViewCell.m
//  MMPay
//
//  Created by 12 on 2017/12/21.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TopUpCollectionViewCell.h"

@implementation TopUpCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius =4;
    self.layer.borderWidth = 1;
    self.layer.borderColor = MMP_CUSTOM_COLOR(218, 218, 218, 1).CGColor;
    self.layer.masksToBounds = YES;
    // Initialization code
}

@end
