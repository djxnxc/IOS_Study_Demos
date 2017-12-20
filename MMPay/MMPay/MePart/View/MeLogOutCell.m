//
//  MeLogOutCell.m
//  MMPay
//
//  Created by 12 on 2017/12/18.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MeLogOutCell.h"
@interface MeLogOutCell()
@property (weak, nonatomic) IBOutlet UIButton *logOutBut;//注销登录

@end
@implementation MeLogOutCell
+(instancetype)initCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"listCell";
    MeLogOutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MeLogOutCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.logOutBut.layer.cornerRadius = 4;
    self.logOutBut.layer.masksToBounds = YES;
    // Initialization code
}
//点击注销登录
- (IBAction)LogOutButClick:(UIButton *)sender {
    if (self.block) {
        self.block(@"logOut");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
