//
//  MeListCell.m
//  MMPay
//
//  Created by 12 on 2017/11/16.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "MeListCell.h"
@interface MeListCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//主题文字
@property (weak, nonatomic) IBOutlet UIButton *phoneBut;//客服电话按钮
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;//右图标
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;//余额
@end
@implementation MeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.phoneBut.hidden = YES;
    self.iconImageV.hidden = YES;
    self.balanceLabel.hidden = YES;
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
//
-(void)setDictData:(NSDictionary *)dictData{
    _dictData = dictData;
    if([_dictData[@"type"] isEqualToString:@"1"]){
        self.titleLabel.text = _dictData[@"cellTitle"];
        self.balanceLabel.hidden = NO;
        self.iconImageV.hidden = NO;
        self.balanceLabel.text = _dictData[@"value"];
        self.iconImageV.image = MMP_IMAGE(_dictData[@"imageName"]);
    }
    if([_dictData[@"type"] isEqualToString:@"2"]){
        self.titleLabel.text = _dictData[@"cellTitle"];
        self.iconImageV.hidden = NO;
        self.iconImageV.image = MMP_IMAGE(_dictData[@"imageName"]);
    }
    if([_dictData[@"type"] isEqualToString:@"3"]){
        self.titleLabel.text = _dictData[@"cellTitle"];
        self.phoneBut.hidden = NO;
        [self.phoneBut setTitle:_dictData[@"value"] forState:UIControlStateNormal];
        self.iconImageV.image = MMP_IMAGE(_dictData[@"imageName"]);
    }
}
//拨打客服电话
- (IBAction)phoneButClick:(UIButton *)sender {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
