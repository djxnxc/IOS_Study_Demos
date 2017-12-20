//
//  HomeSearchVC.m
//  MMPay
//
//  Created by 12 on 2017/12/13.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "HomeSearchVC.h"

@interface HomeSearchVC ()
@property(nonatomic,strong)UISearchBar *searchBar;
@end

@implementation HomeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchBar = [[UISearchBar alloc]initWithFrame: CGRectMake(0, MMP_NAV_STATESBAR_HEIGHT==20?20:44, MMP_ScreenW, 30)];
    self.searchBar.showsCancelButton = YES;
    for (UIView *subView in _searchBar.subviews) {
        if ([subView isKindOfClass:[UIView  class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
            if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                UITextField *textField = [subView.subviews objectAtIndex:0];
                textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                
                //设置输入框边框的颜色
                //                    textField.layer.borderColor = [UIColor blackColor].CGColor;
                //                    textField.layer.borderWidth = 1;
                
                //设置输入字体颜色
                //                    textField.textColor = [UIColor lightGrayColor];
                
                //设置默认文字颜色
                UIColor *color = [UIColor grayColor];
                [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索感兴趣的内容"
                                                                                    attributes:@{NSForegroundColorAttributeName:color}]];
                //修改默认的放大镜图片
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
                imageView.backgroundColor = [UIColor clearColor];
                imageView.image = [UIImage imageNamed:@"gww_search_ misplaces"];
                textField.leftView = imageView;
            }
        }
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.searchBar];
    // Do any additional setup after loading the view.
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
}- (void)didReceiveMemoryWarning {
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
