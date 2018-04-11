//
//  TiyanjinCell.h
//  MyVegetable
//
//  Created by mythkiven on 15/12/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tiyanjin.h"
@protocol TYJChangDelegate <NSObject>
- (void)tyjChoose:(UISwitch*)s father:(id)tyjCell;
@end
@interface TiyanjinCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *choose;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic, weak) id  <TYJChangDelegate>delegate;
@property (strong,nonatomic) Tiyanjin *modell;
@property (nonatomic,strong)NSString* amountValue;
@end
