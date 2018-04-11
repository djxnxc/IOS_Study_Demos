//
//  HuoDongView.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@class HuoDongModel;
@interface HuoDongCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UILabel *topic;

@property (nonatomic, strong) HuoDongModel *hdmodel;
+ (void)initWithModel:(HuoDongModel *)model;
@end
