//
//  MainButton.m
//  T98
//
//  Created by mythkiven on 15/9/9.
//  Copyright (c) 2015年 yunhoo. All rights reserved.
//

#import "MainButton.h"

@implementation MainButton



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.imageView.contentMode = UIViewContentModeCenter;
//        self.titleLabel.font = [UIFont systemFontOfSize:20];
        [self setBackgroundImage:[UIImage resizedImageWithName:@"backgroundColor"] forState:UIControlStateSelected];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted {}
@end
