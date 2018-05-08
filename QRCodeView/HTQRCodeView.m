//
//  HTQRCodeView.m
//  QRCode
//
//  Created by 邓家祥 on 2018/5/7.
//  Copyright © 2018年 邓家祥. All rights reserved.
//

#import "HTQRCodeView.h"
#import <CoreImage/CoreImage.h>
@interface HTQRCodeView()
@property(nonatomic,strong)UIImageView *QRImageV;
@end
@implementation HTQRCodeView

+(HTQRCodeView *)creatQRCodeViewWithFrame:(CGRect )frame QRStr:(NSString *)QRStr{
    HTQRCodeView *view = [[HTQRCodeView alloc]init];
    view.frame = frame;
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSString *string = QRStr;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值 ，注意，这里的value必须是NSData类型

    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码(模糊的)
    CIImage *image = [filter outputImage];
    
    // 4. 显示二维码
    view.QRImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    view.QRImageV.image =[view createNonInterpolatedUIImageFormCIImage:image withSize:CGSizeMake(frame.size.width, frame.size.height)];
    [view addSubview:view.QRImageV];
    return view;
}
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度高度
 *
 *  @return 生成高清的UIImage
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGSize) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
