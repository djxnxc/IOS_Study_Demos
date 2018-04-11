//
//  NameSure.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/20.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "JiaoyiMM.h"
#import "ChongZhi.h"
@interface JiaoyiMM ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sure;
- (IBAction)sureClicked;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *View1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *View2H;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *card;
@property (weak, nonatomic) IBOutlet UITextField *inputName;
@property (weak, nonatomic) IBOutlet UITextField *inputCard;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation JiaoyiMM

- (void)viewDidLoad {
    [super viewDidLoad];
//    JiaoyiMM
    self.View1H.constant = 50*ratioH;
    self.View2H.constant = 50*ratioH;
    self.title = @"设置交易密码";
    self.view.backgroundColor = RGB_gray;
    _sure.backgroundColor = RGB_red;
    self.btnH.constant = 35.0*ratioH;
    _sure.layer.cornerRadius = 35.0/2*ratioH;
    _sure.layer.masksToBounds = YES;
    [_sure setTitle:@"确认" forState:UIControlStateNormal];
    _sure.titleLabel.font = JFont(fontBtn);
    self.name.font = JFont13;
    self.card.font = JFont13;
    self.inputName.font = JFont13;
    self.inputCard.font = JFont13;
    self.detail.font = JFont10;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] init];
    item.title = @"";
    [item setTintColor:RGB_gray];
    self.navigationItem.backBarButtonItem = item;
    if (From1(self)|From2(self)) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(-2, 0, 12, 20);
        UIImage *buttonImage = [UIImage  imageNamed:@"back@2x"];
        buttonImage = [buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [backBtn setImage:buttonImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backa) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}
- (IBAction)sureClicked{
    if (self.isform == 1) {
        
        ChongZhi *c = [[ChongZhi alloc] init];
        c.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:c animated:YES];
    }else{
        ZendaiAlertView *alert = [[ZendaiAlertView alloc]initWithTitle:@"温馨提示" contentText:@"您已成功修改密码。" leftButtonTitle:nil rightButtonTitle:@"确认"];
         __weak JiaoyiMM *sel = self;
        __weak ZendaiAlertView *alertt = alert;
        alert.rightBlock = ^(){
            [sel.navigationController popToRootViewControllerAnimated:YES];
            
            [alertt removeFromSuperviewi];
        };
        [alert show];
    }
}
#pragma mark - 其他
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
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
