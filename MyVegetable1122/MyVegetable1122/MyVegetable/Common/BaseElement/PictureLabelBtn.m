//
//  PictureLabelBtn.m
//  QQZone
//
//  Created by mythkiven on 15/9/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "PictureLabelBtn.h"

@implementation PictureLabelBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
//        self.titleLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
 
        CGFloat imageW = self.width * 0.5;
        CGFloat imageH = self.height;
        return CGRectMake(0, 0, imageW, imageH);
   
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
        CGFloat titleX = self.width *0.5;
        CGFloat titleW = self.width - titleX;
        CGFloat titleH = self.height;
        return CGRectMake(titleX, 0, titleW, titleH);

}
@end
