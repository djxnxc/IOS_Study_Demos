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
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, weak) UIImageView *line;

@end

@implementation DJXScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
//    [self checkPermissions];
    //布局视图
    [self setScan];
    //添加定时器
    [self addTimer];
    // Do any additional setup after loading the view.
}
/**
 * 初始化视图
 */
-(void)initView{
    //背景色
    self.view.backgroundColor = [UIColor blackColor];
    //返回按钮
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    backBut.frame = CGRectMake(10, 20, 60, 30);
    [backBut setTitle:@"取消" forState:UIControlStateNormal];
    [backBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(backButClick) forControlEvents:UIControlEventTouchUpInside];
    //相册按钮
    UIButton *photoBut = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBut.frame = CGRectMake(KMainW-70, 20, 60, 30);
    [photoBut setTitle:@"相册" forState:UIControlStateNormal];
    [photoBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [photoBut addTarget:self action:@selector(photoButClick) forControlEvents:UIControlEventTouchUpInside];
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
    leftV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:leftV];
    //右
    UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(scanX+scanW, scanY, scanX, scanH)];
    rightV.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:rightV];
    //上
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainW, scanY)];
    topV.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:topV];
    [topV addSubview:backBut];
    [topV addSubview:photoBut];
    //下
    UIView *downV = [[UIView alloc]initWithFrame:CGRectMake(0, scanY+scanH, KMainW, scanH+scanY)];
    downV.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:downV];
    //提示语
    UILabel *markLabel = [[UILabel alloc]init];
    markLabel.frame = CGRectMake(0, 0, downV.frame.size.width, 40);
    markLabel.text = @"将二维码/条形码放入框内，即可自动扫描";
    markLabel.textColor = [UIColor whiteColor];
    markLabel.textAlignment = NSTextAlignmentCenter;
    [downV addSubview:markLabel];
    //扫描线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scanW, 2)];
    [self drawLineForImageView:line];
    [scanView addSubview:line];
    self.line = line;
    
    //扫描视图四个角
    CGFloat cornerW = 26.0f;
    for (int i = 0; i < 4; i++) {
        CGFloat imgViewX = (scanW - cornerW) * (i % 2);
        CGFloat imgViewY = (scanW - cornerW) * (i / 2);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, cornerW, cornerW)];
        imgView.backgroundColor = [UIColor redColor];
        [self drawImageForImageView:imgView];
        if (i == 0 || i == 1) {
            imgView.transform = CGAffineTransformRotate(imgView.transform, M_PI_2 * i);
        }else {
            imgView.transform = CGAffineTransformRotate(imgView.transform, - M_PI_2 * (i - 1));
        }
        [scanView addSubview:imgView];
    }
}
//绘制角图片
- (void)drawImageForImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.bounds.size);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条宽度
    CGContextSetLineWidth(context, 6.0f);
    //设置颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor greenColor] CGColor]);
    //路径
    CGContextBeginPath(context);
    [UIView animateWithDuration:10 animations:^{
        //设置起点坐标
        CGContextMoveToPoint(context, 0, imageView.bounds.size.height);
        //设置下一个点坐标
        CGContextAddLineToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, imageView.bounds.size.width, 0);
    }];
    //渲染，连接起点和下一个坐标点
    CGContextStrokePath(context);
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
//绘制线图片
- (void)drawLineForImageView:(UIImageView *)imageView
{
    CGSize size = imageView.bounds.size;
    UIGraphicsBeginImageContext(size);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建一个颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //设置开始颜色
    const CGFloat *startColorComponents = CGColorGetComponents([[UIColor greenColor] CGColor]);
    //设置结束颜色
    const CGFloat *endColorComponents = CGColorGetComponents([[UIColor whiteColor] CGColor]);
    //颜色分量的强度值数组
    CGFloat components[8] = {startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]
    };
    //渐变系数数组
    CGFloat locations[] = {0.0, 1.0};
    //创建渐变对象
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    //绘制渐变
    CGContextDrawRadialGradient(context, gradient, CGPointMake(size.width * 0.5, size.height * 0.5), size.width * 0.25, CGPointMake(size.width * 0.5, size.height * 0.5), size.width * 0.5, kCGGradientDrawsBeforeStartLocation);
    //释放
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
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
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc]init];
        controller.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        controller.delegate =self;
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        [self showAlertWithTitle:@"当前设备不支持访问相册" message:nil sureHandler:nil cancelHandler:nil];

    }
}
//提示弹窗
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message sureHandler:(void (^)())sureHandler cancelHandler:(void (^)())cancelHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:sureHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancelHandler];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
static NSArray * _Nonnull extracted() {
    return [NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil];
}

/**
 * 创建AVCaptureSession对象session
 */
-(void)setScan{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
   
        //添加输入
        AVCaptureDeviceInput *captureInput = [[AVCaptureDeviceInput alloc]initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:nil];
        //添加输出
        AVCaptureMetadataOutput* captureOutput = [[AVCaptureMetadataOutput alloc] init];
//        captureOutput.rectOfInterest = CGRectMake(30, 50, KMainW-60, KMainH-100);
        [captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //创建AVCaptureSession实例
        captureSession = [[AVCaptureSession alloc] init];
         //高质量采集率
        [captureSession setSessionPreset:AVCaptureSessionPresetHigh];
        
        if ([captureSession canAddInput:captureInput]){
             [captureSession addInput:captureInput];
        }
        if ([captureSession canAddOutput:captureOutput]) {
            [captureSession addOutput:captureOutput];
        }
        //条码类型（二维码/条形码）
        captureOutput.metadataObjectTypes = extracted();
        //添加预览图层
        dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            self.previewLayer.frame = CGRectMake(0, 0, KMainW, KMainH);
        [self.view.layer insertSublayer:self.previewLayer atIndex:0];
        [captureSession startRunning];
        });
    });
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [self stopScanning];
    AVMetadataMachineReadableCodeObject* metaData = (AVMetadataMachineReadableCodeObject*)metadataObjects[0];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"二维码内容" message:metaData.stringValue delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
    });
    return ;
}

- (void)addTimer
{
    _distance = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)timerAction
{
    if (_distance++ > KMainW * 0.7) _distance = 0;
    _line.frame = CGRectMake(0, _distance, KMainW * 0.7, 2);
}

- (void)stopScanning
{
    [captureSession stopRunning];
    captureSession = nil;
    [self.previewLayer removeFromSuperlayer];
    [self removeTimer];
}
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
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
