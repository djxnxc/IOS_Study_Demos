//
//  AccountDQSubOneCell.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountJYSubOneCell.h"
#import "AccountJYModel.h"
@implementation AccountJYSubOneCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(AccountJYModel *)model {
    self.leftUp.text = model.leftUp;
    self.leftDOwn.text = model.leftDOwn;
    self.leftDOwn.textColor = RGB_gray115;
    self.rightUp.text = model.rightUp;
    self.rightDown.text = model.rightDown;
    self.rightDown.textColor = RGB_gray115;
    if (model.status==10) {
        self.statusIco.image=[UIImage imageNamed:@"sucess"];
        //self.leftUp.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"success"]];
    }else
    if (model.status==11) {
        self.statusIco.image=[UIImage imageNamed:@"fail"];
    }else {
        self.statusIco.image=[UIImage imageNamed:@"wait"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
