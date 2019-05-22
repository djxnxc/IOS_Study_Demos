//
//  GetAlbumData.m
//  VideoOperationDemo
//
//  Created by 邓家祥 on 2019/5/22.
//  Copyright © 2019年 HT. All rights reserved.
//

#import "GetAlbumData.h"
#import <Photos/Photos.h>
@implementation GetAlbumData

-(NSArray *)getAlbumPictures{
    //1、这里创建一个数组, 用来存储所有的相册
    NSMutableArray *allAlbumArray = [NSMutableArray array];
    
    //2.获取本地相册中所有相簿(相机胶卷和自定义相簿等)
    //获得相机胶卷
    //    PHAssetCollectionTypeAlbum      = 1, // 自定义相册，如QQ
    //    PHAssetCollectionTypeSmartAlbum = 2, // 相机胶卷、我的照片流、屏幕截图、全景照片等
    //    PHAssetCollectionTypeMoment     = 3, // 时刻
    
    //    PHAssetCollectionSubtypeSmartAlbumUserLibrary = 209,  相机胶卷
    
    //    PHAssetCollectionSubtypeAlbumRegular = 2, 在iPhone中自己创建的相册
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [allAlbumArray addObject:cameraRoll];
    //自定义相簿并存储到数组  assetCollections是一个集合, 存储自定义相簿的集合
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        // 相簿存储到数组
        [allAlbumArray addObject:assetCollection];
    }
    //3.获取对应相簿下的所有文件(照片和视频等)
    // 这里假设你的本地相簿数目超过2个, 取出一个示例相簿为albumCollection
    NSMutableArray *pictures = [NSMutableArray array];
#warning 尽量不要取所有的相簿的照片文件，数据量大的话内存报错，此处只取其中一个相簿的照片
    //    PHAssetCollection *albumCollection = allAlbumArray.firstObject;
    for (PHAssetCollection *albumCollection in allAlbumArray) {
        //        NSLog(@"相簿名:%@ 照片个数:%ld", albumCollection.localizedTitle, albumCollection.count);
        NSLog(@"----->相簿名:%@", albumCollection.localizedTitle);
        // 获得相簿albumCollection中的所有PHAsset对象并存储在集合albumAssets中
        PHFetchResult<PHAsset *> *albumAssets = [PHAsset fetchAssetsInAssetCollection:albumCollection options:nil];
        //    遍历集合(albumAssets), 获取对应文件的图片及其他信息
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        // 同步获得图片, 只会返回1张图片
        options.synchronous = NO;
        // 遍历集合, 并获取文件图片及其他信息
        for (PHAsset *asset in albumAssets) {
            // mediaType文件类型
            // PHAssetMediaTypeUnknown = 0, 位置类型
            // PHAssetMediaTypeImage   = 1, 图片
            // PHAssetMediaTypeVideo   = 2, 视频
            // PHAssetMediaTypeAudio   = 3, 音频
            NSInteger fileType = asset.mediaType;
            if (fileType == PHAssetMediaTypeImage) {
                // 是否要原图
                BOOL original = YES;
                CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
                // 获取文件图片
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    // result为文件图片
                    // info其他信息
                    if (result) {
                        [pictures addObject:result];
                    }
                }];
            }
            
        }
    }
    
    return [pictures copy];
}

-(NSArray *)getAlbumVideo{
    
    NSMutableArray *allAlbumArray = [NSMutableArray array];
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [allAlbumArray addObject:cameraRoll];
    //自定义相簿并存储到数组  assetCollections是一个集合, 存储自定义相簿的集合
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        // 相簿存储到数组
        [allAlbumArray addObject:assetCollection];
    }
    
    NSMutableArray *videos = [NSMutableArray array];
    for (PHAssetCollection *assetCollection in allAlbumArray) {
        PHFetchResult<PHAsset *> *albumAssets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        for (PHAsset *asset in albumAssets) {
            if (asset.mediaType == PHAssetMediaTypeVideo) {
                //视频类型
                PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
                options.version =PHVideoRequestOptionsVersionCurrent;
                options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
                [[PHImageManager defaultManager]requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                    if (asset) {
                        NSString *videoURLStr = [NSString stringWithFormat:@"%@",((AVURLAsset *)asset).URL];
                        NSURL *url = [NSURL fileURLWithPath:videoURLStr];
                        NSLog(@"%@",url);
                        [videos addObject:url];
                    }
                    
                    //                    // 获取信息 asset audioMix info
                    //                    // 上传视频时用到data
                    //                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    //                    NSData *data = [NSData dataWithContentsOfURL:urlAsset.URL];
                    //                    if (data) {
                    //                        [videos addObject:urlAsset.URL];
                    //                    }
                }];
            }
        }
        
    }
    return [videos copy];
}


@end
