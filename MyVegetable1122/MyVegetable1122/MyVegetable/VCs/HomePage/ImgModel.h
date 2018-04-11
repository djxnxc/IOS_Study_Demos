//
//  ImgModel.h
//  MyVegetable
//
//  Created by mythkiven on 15/12/13.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgModel : NSObject
/**网络图片*/
@property (nonatomic, copy) NSString *iconUrl;
/**本地图片名*/
@property (nonatomic, copy) NSString *iconName;
/**图片ID*/
@property (nonatomic, copy) NSString *iconID;
/**跳转网址**/
@property(nonatomic,strong)NSString* myUrl;
@end
