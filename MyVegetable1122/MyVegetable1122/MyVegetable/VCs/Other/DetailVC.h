//
//  AccountDQ.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/23.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailVC : UIViewController
@property (nonatomic, copy) NSString *urlStr;
 
//选择那一页 0 1页 1 2页
@property (nonatomic, assign) NSInteger pageNum;
//选择哪一行
@property (nonatomic, assign) NSInteger scrollNum;

//从那个地方来
@property (nonatomic, assign) NSInteger isfrom;

/**产品ID*/
@property (nonatomic, copy) NSString *productId;

@end
