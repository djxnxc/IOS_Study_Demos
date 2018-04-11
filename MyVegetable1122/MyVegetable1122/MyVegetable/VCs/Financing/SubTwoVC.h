//
//  SubTwoVC.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/12.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

 
#import <UIKit/UIKit.h>
@interface SubTwoVC : UIViewController
@property (nonatomic,assign) NSInteger pageNum;
@property (strong, nonatomic) IBOutlet UIScrollView *svt;
@property(nonatomic,strong)UINavigationController* nc;
//@property (nonatomic, strong) NSMutableArray *productData;

@end
