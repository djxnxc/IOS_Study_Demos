//
//  UIView+UIViewAdditions.m
//  CommunityPersonal
//
 
//

#import "UIView+UIViewAdditions.h"


#define NotificationCenter  [NSNotificationCenter defaultCenter]
#define MainScreen          [UIScreen mainScreen]
#define SCREEN_WIDTH  MainScreen.bounds.size.width
#define SCREEN_HEIGHT MainScreen.bounds.size.height

@implementation UIView (UIViewAdditions)

#pragma mark - Setter and getter.

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// readonly.
- (CGFloat)screenX {
    CGFloat x = 0.0f;
    for (UIView *view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenY {
    CGFloat y = 0.0f;
    for (UIView *view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

// 只支持竖屏！ 这三个key都被废弃了~~~
- (NSDictionary *)userInfoForKeyboardNotification {
//    CGRect bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    CGPoint centerBegin = CGPointMake(floor(SCREEN_WIDTH/2 - floor(self.width/2)), SCREEN_HEIGHT + self.height/2);
    CGPoint centerEnd   = CGPointMake(floor(SCREEN_WIDTH/2 - floor(self.width/2)), SCREEN_HEIGHT - self.height/2);
    
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
//            [NSValue valueWithCGRect:bounds], UIKeyboardBoundsUserInfoKey,
            [NSValue valueWithCGPoint:centerBegin], UIKeyboardFrameBeginUserInfoKey,
            [NSValue valueWithCGPoint:centerEnd], UIKeyboardFrameEndUserInfoKey,
             nil];
}

- (void)presentAsKeyboardAnimationDidStop {
    [NotificationCenter postNotificationName:UIKeyboardDidShowNotification object:self userInfo:[self userInfoForKeyboardNotification]];
}

- (void)dismissAdKeyboardAnimationDidStop {
    [NotificationCenter postNotificationName:UIKeyboardDidHideNotification object:self userInfo:[self userInfoForKeyboardNotification]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)presentAsKeyboardInView:(UIView *)containingView {
    [NotificationCenter postNotificationName:UIKeyboardWillShowNotification object:self userInfo:[self userInfoForKeyboardNotification]];
    
    self.top = containingView.height;
    [containingView addSubview:self];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(presentAsKeyboardAnimationDidStop)];
    self.top -= self.height;
    [UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dismissAsKeyboardInView:(BOOL)animated {
    [NotificationCenter postNotificationName:UIKeyboardWillHideNotification object:self userInfo:[self userInfoForKeyboardNotification]];
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dismissAdKeyboardAnimationDidStop)];
        self.top += self.height;
        [UIView commitAnimations];
        
    } else {
        [self dismissAdKeyboardAnimationDidStop];
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
- (void)hiddenAllSubviews {
    for (UIView *v  in self.subviews) {
        v.hidden = YES;
    }
    
}
- (void)showAllSubviews {
    for (UIView *v  in self.subviews) {
        v.hidden = NO;
    }
}


@end
