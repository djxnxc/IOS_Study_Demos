//
//  NearbyVC.m
//  MMPay
//
//  Created by 12 on 2017/11/14.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "NearbyVC.h"

@interface NearbyVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navStateBarHeight;
@property (weak, nonatomic) IBOutlet UIView *searchTextView;


@end

@implementation NearbyVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}
-(void)initView{
    self.navStateBarHeight.constant = MMP_NAV_STATESBAR_HEIGHT;
    self.searchTextView.layer.cornerRadius = 15;
    self.searchTextView.layer.masksToBounds = YES;
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
