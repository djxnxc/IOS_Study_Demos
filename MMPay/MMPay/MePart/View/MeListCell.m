//
//  MeListCell.m
//  MMPay
//
//  Created by 12 on 2017/11/16.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MeListCell.h"
@interface MeListCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;//图标
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//主题文字
@end
@implementation MeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)initCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"listCell";
    MeListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MeListCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(void)setModel:(MeModel *)model{
    _model = model;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
