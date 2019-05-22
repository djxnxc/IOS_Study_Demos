//
//  VideoListCell.h
//  VideoOperationDemo
//
//  Created by 邓家祥 on 2019/5/21.
//  Copyright © 2019年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//AVAsset：一个用于获取多媒体信息的抽象类，但不能直接使用
//AVURLAsset：AVAsset的子类，可以根据一个URL路径创建一个包含媒体信息的AVURLAsset对象
//AVPlayerItem：一个媒体资源管理对象，用于管理视频的基本信息和状态，一个AVPlayerItem对应一个视频资源
//AVPlayer：负责视频播放、暂停、时间控制等操作
//AVPlayerLayer：负责显示视频的图层，如果不设置此属性，视频就只有声音没有图像
NS_ASSUME_NONNULL_BEGIN

@interface VideoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoFirstImage_imageV;
@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property (nonatomic,strong)AVPlayerItem *currentPlayerItem;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,strong)AVPlayerLayer *avLayer;
-(void)stopPlay;
-(void)startPlay;
@end

NS_ASSUME_NONNULL_END
