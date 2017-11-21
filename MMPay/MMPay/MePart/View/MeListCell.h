//
//  MeListCell.h
//  MMPay
//
//  Created by 12 on 2017/11/16.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeModel;
@interface MeListCell : UITableViewCell
@property(nonatomic,strong)MeModel *model;
+(instancetype)initCellWithTableView:(UITableView *)tableView;
@end
