//
//  helpCell.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/16.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class helpModel,AccountModel;
@interface helpCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *imgeNext;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *h;
@property (nonatomic, strong) helpModel *helpmodel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *w;
@property (nonatomic, strong) AccountModel *accountmodel;
@end
