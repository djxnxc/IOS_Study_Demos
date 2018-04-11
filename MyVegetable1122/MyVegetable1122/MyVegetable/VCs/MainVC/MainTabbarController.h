//
//  MyTabBarController.h
//  LoveXianMian
//
//  Created by 蒋孝才 on 15/7/1.
//  Copyright (c) 2015年 蒋孝才. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabbarController : UITabBarController
/** 1 首页 2理财 3账户  发的通知 0定期 99活期 101新手标*/
@property (nonatomic, assign) NSInteger isfrom;
- (void)createTabBarControllers;
-(void)setTabBarItems;
- (id)initWith:(NSInteger)num;
@end