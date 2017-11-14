//
//  HomeHeaderCell.h
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeButProtocol.h"
@interface HomeHeaderCell : UITableViewCell
@property (nonatomic,strong)id <HomeButProtocol>delegate;
@end
