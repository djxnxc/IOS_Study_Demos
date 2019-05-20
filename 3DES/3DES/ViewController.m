//
//  ViewController.m
//  3DES
//
//  Created by 邓家祥 on 2018/9/12.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "ViewController.h"
#import "DesUtil.h"
#import "NSString+Hash.h"
@interface ViewController ()
//key
@property (weak, nonatomic) IBOutlet UITextField *desKey_textField;
//原始数据
@property (weak, nonatomic) IBOutlet UITextView *data_textView;
//加密数据
@property (weak, nonatomic) IBOutlet UITextView *des_textView;
//解密数据
@property (weak, nonatomic) IBOutlet UITextView *desDecryption_textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data_textView.text = @"646a7831323334353637303030303030";
    self.des_textView.text = @"";
    self.desDecryption_textView.text = @"";
    self.desKey_textField.text = @"c5ac2s38197fc7cd";
    // Do any additional setup after loading the view, typically from a nib.
}
//加密
- (IBAction)encryptionDes_btnClick:(UIButton *)sender {
    if ([self.desKey_textField.text length]>0&&self.data_textView.text.length>0) {
     self.des_textView.text = [DesUtil encryptUseDES:self.data_textView.text key:self.desKey_textField.text];
//        self.des_textView.text = [NSString encrypt3DES:self.data_textView.text withKey:self.desKey_textField.text];

    }else{
        
    }
}
//解密
- (IBAction)decryptionDes_btnClick:(UIButton *)sender {
    if ([self.desKey_textField.text length]>0&&self.des_textView.text.length>0) {
       self.desDecryption_textView.text=[DesUtil decryptUseDES:self.des_textView.text key:self.desKey_textField.text];
//        self.desDecryption_textView.text=[NSString decrypt3DES:self.des_textView.text withKey:self.desKey_textField.text];


    }else{
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
