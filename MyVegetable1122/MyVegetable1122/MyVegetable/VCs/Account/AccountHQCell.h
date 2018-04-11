//
//  AccountHQCell.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountHQCellModel;
@interface AccountHQCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *monkey;
@property (weak, nonatomic) IBOutlet UILabel *monkeyGet;
@property (nonatomic,assign)CGFloat SBW;
@property (strong, nonatomic) AccountHQCellModel *model;
-(id)initWithNib:(CGFloat)sw;
@end
