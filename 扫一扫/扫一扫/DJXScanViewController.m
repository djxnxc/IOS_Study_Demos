//
//  DJXScanViewController.m
//  扫一扫
//
//  Created by 12 on 2017/11/8.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "DJXScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#define KMainW [UIScreen mainScreen].bounds.size.width
#define KMainH [UIScreen mainScreen].bounds.size.height
@interface DJXScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    AVCaptureSession *captureSession;
}
@end

@implementation DJXScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initView];
    [self checkPermissions];
    [self setScan];

    
    // Do any additional setup after loading the view.
}
/**
 * 初始化视图
 */
-(void)initView{
    //返回按钮
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    backBut.frame = CGRectMake(10, 20, 60, 30);
    [backBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(backButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBut];
    //相册按钮
    UIButton *photoBut = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBut.frame = CGRectMake(KMainW-50, 20, 60, 30);
    [photoBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [photoBut addTarget:self action:@selector(photoButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoBut];
    //扫描框背景布局上下左右分别配置
    CGFloat scanW = KMainW*0.7;
    CGFloat scanH = scanW;
    CGFloat scanX = KMainW*0.3*0.5;
    CGFloat scanY =(KMainH-scanH)*0.5;
    UIView *scanView = [[UIView alloc]init];
    scanView.frame = CGRectMake(scanX, scanY, scanW, scanH);
    [self.view addSubview: scanView];
    //左
    UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0, scanY, scanX, scanH)];
    leftV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:leftV];
    //右
    UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(scanX+scanW, scanY, scanX, scanH)];
    rightV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:rightV];
    //上
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KMainW, scanY-64)];
    topV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:topV];
    //下
    UIView *downV = [[UIView alloc]initWithFrame:CGRectMake(0, scanY+scanH, KMainW, scanH+scanY)];
    downV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:downV];
    //提示语
    UILabel *markLabel = [[UILabel alloc]init];
    markLabel.frame = CGRectMake(0, 0, downV.frame.size.width, 40);
    markLabel.text = @"将二维码/条形码放入框内，即可自动扫描";
    markLabel.textAlignment = NSTextAlignmentCenter;
    [downV addSubview:markLabel];
}
/**
 * 返回
 */
-(void)backButClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 * 打开相册
 */
-(void)photoButClick{
    
}
/**
 * 权限检查
 */
-(void)checkPermissions{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        //请求权限
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted == NO){
            }
            
        }];
    }

}
/**
 * 创建AVCaptureSession对象session
 */
-(void)setScan{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //创建AVCaptureSession实例
        captureSession = [[AVCaptureSession alloc] init];
        //添加输入
        AVCaptureDeviceInput *captureInput = [[AVCaptureDeviceInput alloc]initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:nil];
        //添加输出
        AVCaptureMetadataOutput* captureOutput = [[AVCaptureMetadataOutput alloc] init];
        captureOutput.rectOfInterest = CGRectMake(30, 50, KMainW-60, KMainH-100);
        [captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [captureSession setSessionPreset:AVCaptureSessionPresetHigh];
        
        if ([captureSession canAddInput:captureInput]) [captureSession addInput:captureInput];
        if ([captureSession canAddOutput:captureOutput]) [captureSession addOutput:captureOutput];
        //条码类型（二维码/条形码）
        captureOutput.metadataObjectTypes = [NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil];
        //添加预览图层
        AVCaptureVideoPreviewLayer* previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        previewLayer.frame = CGRectMake(0, 0, KMainW, KMainH);
        [self.view.layer insertSublayer:previewLayer atIndex:0];
        [captureSession startRunning];
    });
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [captureSession stopRunning];
    AVMetadataMachineReadableCodeObject* metaData = (AVMetadataMachineReadableCodeObject*)metadataObjects[0];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"二维码内容" message:metaData.stringValue delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
    });
    return ;
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
