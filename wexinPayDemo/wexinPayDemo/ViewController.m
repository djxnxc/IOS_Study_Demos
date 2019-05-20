//
//  ViewController.m
//  wexinPayDemo
//
//  Created by 邓家祥 on 2018/11/3.
//  Copyright © 2018年 HTTest. All rights reserved.
//

#import "ViewController.h"
#import <WXApi.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnClick:(id)sender {
    OpenWebviewReq *req = [[OpenWebviewReq alloc] init];
    req.url = @"https://api.mch.weixin.qq.com/papay/entrustweb?appid=wxd847f144022e3d5b&contract_code=b0e836f09b7548f69fe7844d50c87138&contract_display_account=mt&mch_id=1510826201&notify_url=http%253A%252F%252Fwenzhen.s1.natapp.cc%252FwxpayController%252FcontractNotify&plan_id=122879&request_serial=111&return_app=3&timestamp=1541227537&version=1.0&sign=70755B96B616963010AA90AA33B6CC4E";
    [WXApi sendReq:req];
}


@end
