//
//  WeChart.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "WeChart.h"

@interface WeChart ()

@end

@implementation WeChart

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer* tapdyh=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveDyh)];
    [self.wxdyh addGestureRecognizer:tapdyh];
    UITapGestureRecognizer* tapfwh=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wxFwh)];
    [self.wxfwh addGestureRecognizer:tapfwh];
    index=0;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    self.title=@"关注微信";
}

#pragma mark  返回
- (void)backa{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveDyh
{
    index=1;
    [self saveImageToPhotos:self.wxdyh.image];
}
-(void)wxFwh
{
    index=2;
    [self saveImageToPhotos:self.wxfwh.image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)saveImageToPhotos:(UIImage*)savedImage

{

    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

}

// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{

    NSString *msg = nil ;

    if(error != NULL){

        msg = @"保存图片失败" ;

    }else{

        msg = @"保存图片成功" ;

    }
    
    if (index==1) {
        [self.view makeToast:@"微信订阅号二维码成功保存到相册！"];
    }
    if (index==2) {
        [self.view makeToast:@"微信服务号二维码成功保存到相册！"];
    }
    
}
@end
