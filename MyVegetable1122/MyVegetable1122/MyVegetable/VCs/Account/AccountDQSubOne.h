//
//  AccountDQSubOne.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountDQSubOne : UIViewController
//1361299
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, copy) NSString *leftup;
@property (nonatomic, copy) NSString *leftdown;
@property(nonatomic,strong)NSDictionary* dataDictionary;
-(void)reflash;

@end
