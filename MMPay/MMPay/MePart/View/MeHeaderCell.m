//
//  MeHeaderCell.m
//  MMPay
//
//  Created by 12 on 2017/11/16.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MeHeaderCell.h"
@interface MeHeaderCell()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
@implementation MeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topView.backgroundColor = MMP_BLUECOLOR;
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"listCell";
    MeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MeHeaderCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
