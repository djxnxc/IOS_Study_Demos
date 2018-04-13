//
//  HomePageVC.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/11.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerFactory.h"

@class CCProgressView,PICircularProgressView;
@interface HomePageVC : UIViewController
{
    CGAffineTransform currentTransform;
    CGAffineTransform newTransform;
    double r;
    BOOL iphone4SFlag;
    NSString* myCode;
    CGFloat process;
}
@property (strong, nonatomic) PICircularProgressView *progressView;
@property (nonatomic , strong)  NSTimer *theTimer;
@property(nonatomic,strong)CCProgressView * circleChart;
@property (nonatomic, copy) NSString *urlStr;
@property (strong, nonatomic) IBOutlet UIImageView *minIco;
@property (strong, nonatomic) IBOutlet UILabel *yc;
@property (strong, nonatomic) IBOutlet UILabel *fb;
@property (strong, nonatomic) IBOutlet UILabel *yk;

@end
