//
//  DJXTabBar.m
//  DJXTabBar
//
//  Created by 12 on 2017/11/7.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "DJXTabBar.h"
#import "MyViewController.h"
#import "CartViewController.h"
#import "FindViewController.h"
#import "CategoryViewController.h"
#import "HomeViewController.h"
#import "DJXNavigationController.h"
@interface DJXTabBar ()
@property(nonatomic,strong)HomeViewController *homeVC;
@property(nonatomic,strong)CartViewController *cartVC;
@property(nonatomic,strong)FindViewController *findVC;
@property(nonatomic,strong)CategoryViewController *categoryVC;
@property(nonatomic,strong)MyViewController *myVC;
@end

@implementation DJXTabBar
-(HomeViewController *)homeVC{
    if (!_homeVC) {
        _homeVC = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    }
    return _homeVC;
}

-(CartViewController *)cartVC{
    if (!_cartVC) {
        _cartVC = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
    }
    return _cartVC;
}
-(FindViewController *)findVC{
    if (!_findVC) {
        _findVC = [[FindViewController alloc]initWithNibName:@"FindViewController" bundle:nil];
    }
    return _findVC;
}
-(CategoryViewController *)categoryVC{
    if (!_categoryVC) {
        _categoryVC = [[CategoryViewController alloc]initWithNibName:@"CategoryViewController" bundle:nil];
    }
    return _categoryVC;
}
-(MyViewController *)myVC{
    if (!_myVC) {
        _myVC = [[MyViewController alloc]initWithNibName:@"MyViewController" bundle:nil];
    }
    return _myVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVCS];
    // Do any additional setup after loading the view.
}
//添加视图
-(void)addChildVCS{
    [self addChildVC:self.homeVC title:@"首页" imageName:@"tabBar_home_normal" selectImageName:@"tabBar_home_press"];
    [self addChildVC:self.categoryVC title:@"分类" imageName:@"tabBar_category_normal" selectImageName:@"tabBar_category_press"];
    [self addChildVC:self.findVC title:@"发现" imageName:@"tabBar_find_normal" selectImageName:@"tabBar_find_press"];
    [self addChildVC:self.cartVC title:@"购物车" imageName:@"tabBar_cart_normal" selectImageName:@"tabBar_cart_press"];
    [self addChildVC:self.myVC title:@"我的" imageName:@"tabBar_myJD_normal" selectImageName:@"tabBar_myJD_press"];

}
-(void)addChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    DJXNavigationController *nav = [[DJXNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
