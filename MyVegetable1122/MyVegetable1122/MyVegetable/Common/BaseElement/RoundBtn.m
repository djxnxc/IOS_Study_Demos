//
//  RoundBtn.m
//  T98
//
//  Created by mythkiven on 15/9/11.
//  Copyright (c) 2015年 yunhoo. All rights reserved.
//

#import "RoundBtn.h"

@implementation RoundBtn

- (void)setHighlighted:(BOOL)highlighted {}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CALayer *layer=[self layer];
    [layer setMasksToBounds:YES];
    [self.layer setCornerRadius:self.width/2];
    
    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
}
@end
