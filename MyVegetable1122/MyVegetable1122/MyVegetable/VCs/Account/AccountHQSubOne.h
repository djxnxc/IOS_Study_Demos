//
//  AccountHQSubOne.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountBaseVC.h"

@interface AccountHQSubOne : AccountBaseVC<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSMutableArray *data;
-(void)setTableViewFrame:(CGRect)frame;
-(void)reflash;
@end
