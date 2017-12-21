//
//  TopUpCell.h
//  MMPay
//
//  Created by 12 on 2017/12/21.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUpCell : UITableViewCell
@property(nonatomic,copy)void (^selectblcok)(NSString *str);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;//手机号输入框
@property (weak, nonatomic) IBOutlet UIButton *addressBookBut;//通讯录按钮
@property(nonatomic,strong)NSArray *arrData;//collectionView数据源
@end
