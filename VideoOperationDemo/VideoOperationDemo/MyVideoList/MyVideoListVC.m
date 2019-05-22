//
//  MyVideoListVC.m
//  VideoOperationDemo
//
//  Created by 邓家祥 on 2019/5/21.
//  Copyright © 2019年 HT. All rights reserved.
//

#import "MyVideoListVC.h"
#import <AVFoundation/AVFoundation.h>//获取数据源
#import <MediaPlayer/MediaPlayer.h>//播放视频
#import <Photos/Photos.h>
#import <AVKit/AVKit.h>
#import "VideoListCell.h"
//iPhone X
#define HTIS_IPHONE_X ((HTSCREENH_HEIGHT > 736.0) ? YES : NO)
//导航栏高度
#define HTHeight_NavContentBar 44.0f
//状态栏高度
#define HTHeight_StatusBar ((HTIS_IPHONE_X==YES)?44.0f: 20.0f)
//导航栏+状态栏高度
#define HTHeight_NavBar ((HTIS_IPHONE_X==YES)?88.0f: 64.0f)
//tabBar高度
#define HTHeight_TabBar ((HTIS_IPHONE_X==YES)?83.0f: 49.0f)
#define HTBottom_TabBar ((HTIS_IPHONE_X==YES)?34.0f: 0.0f)
//屏幕宽
#define HTSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
//屏幕高
#define HTSCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height



@interface MyVideoListVC ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
//视频列表
@property (weak, nonatomic) IBOutlet UITableView *videoList_tab;
@property (strong, nonatomic) MPMediaPickerController *paler;
@property (nonatomic, assign) NSInteger scrollToIndex;//记录滚动到第几行，默认是0

@end

@implementation MyVideoListVC


-(NSMutableArray *)videoData{
    if (!_videoData) {
        _videoData = [NSMutableArray array];
    }
    return _videoData;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
//UIGestureRecognizerDelegate 重写侧滑协议
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return [self gestureRecognizerShouldBegin];
}
- (BOOL)gestureRecognizerShouldBegin {
    //NSLog(@"~~~~~~~~~~~%@控制器 滑动返回~~~~~~~~~~~~~~~~~~~",[self class]);
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    // Do any additional setup after loading the view from its nib.
}
//初始化
-(void)initView{
    self.videoList_tab.delegate = self;
    self.videoList_tab.dataSource = self;
    self.videoList_tab.pagingEnabled = YES;
    if (@available(ios 11.0,*)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    self.videoList_tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.videoList_tab registerNib:[UINib nibWithNibName:@"VideoListCell" bundle:nil] forCellReuseIdentifier:@"videoCell"];
    self.scrollToIndex = 0;
    [self getDatas];
}
#pragma mark - UITableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.videoList_tab.frame.size.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
    if (self.videoData.count>0) {
        cell.videoFirstImage_imageV.image = [self getImage:[NSURL fileURLWithPath:_videoData[indexPath.row]]];
        cell.path =_videoData[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==0) {
        [cell  startPlay];
    }
    return cell;
}
//
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    VideoListCell *LastCell = [self.videoList_tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.scrollToIndex inSection:0]];
    [LastCell stopPlay];
}
//滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    NSLog(@"----->%lf",point.y);
    
    self.scrollToIndex = scrollView.contentOffset.y/(HTSCREENH_HEIGHT - HTHeight_StatusBar -HTBottom_TabBar);
    //滚动停止后当前cell
    VideoListCell *NowCell = [self.videoList_tab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.scrollToIndex inSection:0]];
    [NowCell startPlay];
}
//获取本地视频缩略图
- (UIImage *)getImage:(NSURL *)URL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:URL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return thumb;
}
//获取相册视频
-(void)getDatas{
    __weak typeof(self) weakSelf = self;
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:nil];
    // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
    dispatch_async(dispatch_queue_create(0, 0), ^{
        for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
            // 获取一个资源（PHAsset）
            PHAsset *phAsset = assetsFetchResults[i];
            if (phAsset.mediaType == PHAssetMediaTypeVideo) {
                //只获取视频
                PHVideoRequestOptions *options2 = [[PHVideoRequestOptions alloc] init];
                options2.version = PHVideoRequestOptionsVersionCurrent;
                options2.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                options2.networkAccessAllowed = YES;
                PHImageManager *manager = [PHImageManager defaultManager];
                [manager requestAVAssetForVideo:phAsset options:options2 resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                    //video路径获取
                    if (asset && [asset isKindOfClass:[AVURLAsset class]] && [NSString stringWithFormat:@"%@",((AVURLAsset *)asset).URL].length > 0) {
                        NSString *videoURLStr = [NSString stringWithFormat:@"%@",((AVURLAsset *)asset).URL];
                        NSURL *url = [NSURL fileURLWithPath:videoURLStr];
                        NSLog(@"%@",url);
                        [weakSelf.videoData addObject:videoURLStr];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf.videoList_tab reloadData];
                        });
                    }
                }];
            }
        }
        
    });
    
    
}
-(void)dealloc{
    NSLog(@"-------引用计数为0--------");
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
