//
//  MeLogOutCell.h
//  MMPay
//
//  Created by 12 on 2017/12/18.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeLogOutCell : UITableViewCell
+(instancetype)initCellWithTableView:(UITableView *)tableView;
@property(nonatomic,copy)void (^block)(NSString *logOut);
@end
