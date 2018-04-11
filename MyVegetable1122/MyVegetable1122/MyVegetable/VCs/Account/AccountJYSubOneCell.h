//
//  AccountDQSubOneCell.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountJYModel;
@interface AccountJYSubOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftUp;
@property (weak, nonatomic) IBOutlet UILabel *leftDOwn;

@property (weak, nonatomic) IBOutlet UILabel *rightUp;
@property (weak, nonatomic) IBOutlet UILabel *rightDown;
@property (nonatomic, strong) AccountJYModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *statusIco;

@end
