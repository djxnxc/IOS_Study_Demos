//
//  DJXTabBar.m
//  DJXTabBar
//
//  Created by 12 on 2017/11/7.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "DJXTabBar.h"
#import "HomeVC.h"
#import "NearbyVC.h"
#import "FriendsVC.h"
#import "MeVC.h"
#import "DJXNavigationController.h"
@interface DJXTabBar ()
@property(nonatomic,strong)HomeVC *homeVC;
@property(nonatomic,strong)NearbyVC *nearbyVC;
@property(nonatomic,strong)FriendsVC *friendVC;
@property(nonatomic,strong)MeVC *meVC;
@end

@implementation DJXTabBar
-(HomeVC *)homeVC{
    if (!_homeVC) {
        _homeVC = [[HomeVC alloc]initWithNibName:@"HomeVC" bundle:nil];
    }
    return _homeVC;
}

-(NearbyVC *)nearbyVC{
    if (!_nearbyVC) {
        _nearbyVC = [[NearbyVC alloc] initWithNibName:@"NearbyVC" bundle:nil];
    }
    return _nearbyVC;
}
-(FriendsVC *)friendVC{
    if (!_friendVC) {
        _friendVC = [[FriendsVC alloc]initWithNibName:@"FriendsVC" bundle:nil];
    }
    return _friendVC;
}
-(MeVC *)meVC{
    if (!_meVC) {
        _meVC = [[MeVC alloc]initWithNibName:@"MeVC" bundle:nil];
    }
    return _meVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVCS];
    // Do any additional setup after loading the view.
}
//添加视图
-(void)addChildVCS{
    [self addChildVC:self.homeVC title:@"Home" imageName:@"icon_home" selectImageName:@"icon_home_selected"];
    [self addChildVC:self.nearbyVC title:@"Nearby" imageName:@"icon_nearby" selectImageName:@"icon_nearby_selected"];

    [self addChildVC:self.friendVC title:@"Friends" imageName:@"icon_Friends" selectImageName:@"icon_Friends_selected"];
    [self addChildVC:self.meVC title:@"Me" imageName:@"icon_me" selectImageName:@"icon_me_selected"];

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
