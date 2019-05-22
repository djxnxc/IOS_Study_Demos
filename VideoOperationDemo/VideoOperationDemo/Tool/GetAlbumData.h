//
//  GetAlbumData.h
//  VideoOperationDemo
//
//  Created by 邓家祥 on 2019/5/22.
//  Copyright © 2019年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetAlbumData : NSObject
//获取相册的所有图片
-(NSArray *)getAlbumPictures;
//获取相册的所有视频
-(NSArray *)getAlbumVideo;
@end

NS_ASSUME_NONNULL_END
