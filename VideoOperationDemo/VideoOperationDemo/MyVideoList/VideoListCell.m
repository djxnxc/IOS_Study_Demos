//
//  VideoListCell.m
//  VideoOperationDemo
//
//  Created by 邓家祥 on 2019/5/21.
//  Copyright © 2019年 HT. All rights reserved.
//

#import "VideoListCell.h"

@implementation VideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor blackColor];
    // Initialization code
}

-(void)setPath:(NSString *)path{
    _path = path;
}
-(void)startPlay{
    [self.avLayer removeFromSuperlayer];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:_path]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    self.avLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    _avLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    _avLayer.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:_avLayer];
    [self.player play];

}
-(void)stopPlay{
    [self.player pause];
    [self.avLayer removeFromSuperlayer];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
