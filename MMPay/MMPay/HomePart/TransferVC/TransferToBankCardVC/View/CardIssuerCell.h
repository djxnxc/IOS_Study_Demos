//
//  CardIssuerCell.h
//  MMPay
//
//  Created by 12 on 2017/12/19.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardIssuerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;//银行图标
@property (weak, nonatomic) IBOutlet UILabel *label;//银行名称
@property(nonatomic,strong)NSDictionary *dictData;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
