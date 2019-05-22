//
//  ViewController.m
//  VideoOperationDemo
//
//  Created by 邓家祥 on 2019/5/21.
//  Copyright © 2019年 HT. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import "GetAlbumData.h"
// 视频URL路径
#define KVideoUrlPath   \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"VideoURL"]
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *videoData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GetAlbumData *albumData = [[GetAlbumData alloc]init];
//    NSArray *pictures = [albumData getAlbumPictures];
//    for (UIImage *picture in pictures) {
//        NSLog(@"%@",picture);
//    }
    NSArray *videos = [albumData getAlbumVideo];
    for (NSString *url in videos) {
        NSLog(@"---------->%@",url);
    }
    // Do any additional setup after loading the view, typically from a nib.
}
//获取视频
- (IBAction)getVideo:(id)sender {
//    [self getDatas];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"选择视频" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册读取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotos];
    }];
//    __weak typeof(self) weakSelf = self;
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"录制视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self recordVideo];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//打开相册
-(void)openPhotos{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;//相册包含照片跟视频
    NSString *requiredMediaType = (NSString *)kUTTypeMovie;//设置只读取视频
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.delegate = self;
    [imagePicker setMediaTypes:@[requiredMediaType]];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//录制视频
-(void)recordVideo{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//相册包含照片跟视频
    imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    NSString *requiredMediaType = (NSString *)kUTTypeMovie;//设置只读取视频
    [imagePicker setMediaTypes:@[requiredMediaType]];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark -UIImagePickerController代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeMovie]) {
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //如果是录像，先将视频保存到相册
            NSString* path = [[info objectForKey:UIImagePickerControllerMediaURL] path];
            UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            [picker dismissViewControllerAnimated:YES completion:nil];

        }
        NSString* path = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        NSLog(@"%@",path);
        [picker dismissViewControllerAnimated:YES completion:nil];

    }
}
// 视频保存回调

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
    
    NSLog(@"%@",videoPath);
    
    NSLog(@"%@",error);
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@"------引用计数为0-------");
}
@end
