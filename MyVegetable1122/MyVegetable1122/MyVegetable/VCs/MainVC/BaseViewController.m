//
//  BaseViewController.m
//  LoveXianMian
//
//  Created by 蒋孝才 on 15/7/1.
//  Copyright (c) 2015年 蒋孝才. All rights reserved.
//

#import "BaseViewController.h"

//#import "CategoryVC.h"
//#import "SearchVC.h"
//#import "SetVC.h"
//#import "DetailVC.h"
//#import "BaseModel.h"
//
//#import "BaseCell.h"

@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIBarPositioningDelegate>
{
    UITableView *_tableView;// 是否有网络
    NSMutableArray *_dataArr;//装在数据数组
    
}

@end

@implementation BaseViewController

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray arrayWithCapacity:0];
  //设置导航控制器元素
     [self setTabBarItems];
    
   
}
#pragma mark - 导航控制器-元素设置
    -(void)setTabBarItems{
        // 文字数组
        NSArray *titleArr=@[@"首页",@"理财",@"账户",@"帮助"];
        // 普通图片名数组
        NSArray *normalImgArr = @[@"shouye-hui.png",
                                  @"licai-hui",
                                  @"zhanghu-hui",
                                  @"help-hui" ];
        
        NSArray *selectedImgArr = @[@"shouye-red.png",
                                    @"licai-red",
                                    @"zhanghu-red",
                                    @"help-red" ];
        NSMutableArray *n = [NSMutableArray array];
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        // 循环设置tabbarItem的文字，图片
        for (int i=0; i< 4; i++) {
            UIBarButtonItem *btn;
            //填充图片
            UIImage *img=[UIImage imageNamed:selectedImgArr[i]];
            //图片填充模式 imageWithRenderingMode设置渲染模式
            img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            btn =[[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:img];
            [n addObject:flexItem];
            [n addObject:btn];
        }
        [n addObject:flexItem];
        NSArray *a = [NSArray arrayWithArray:n ];
        [self setToolbarItems:a animated:YES];
        [[UITabBarItem  appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_red} forState:UIControlStateSelected];//设置TabBarItem字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TabBarItemFontSize]} forState:UIControlStateNormal];//设置
        [[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:NavFontSize]}];
        
        
    }



#pragma mark  导航控制器-创建导航栏元素
- (UIButton *)createButtonWithTitle:(NSString *)title backImgName:(NSString *)imgName frame:(CGRect)frame titleColor:(UIColor *)color{
    UIButton *Btn = [ UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitleColor:color forState:UIControlStateNormal];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    Btn.frame = frame;
    return Btn;
}


















@end
