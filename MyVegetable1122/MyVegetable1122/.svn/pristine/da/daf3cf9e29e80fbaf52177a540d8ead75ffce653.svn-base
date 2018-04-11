//




//

#import "JAlertManager.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIView+UIViewAdditions.h"

#define SharedApplication   [UIApplication sharedApplication]

@interface JAlertManager ()

@property (nonatomic, strong) UIControl *undermostBackgroundControl;
@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIViewController *devViewController;

@end

static JAlertManager *defaultManager = nil;

static CGFloat kAnimationDuration = 0.2;

static CGFloat kTransformAppearingScale = 1.2;
static CGFloat kTransformDisappearingScale = 0.8;

@implementation JAlertManager

+ (instancetype)sharedAlertManager {
    @synchronized (self) {
        if (defaultManager == nil) {
            defaultManager = [[self alloc] init];
        }
    }
    return defaultManager;
}

#pragma mark 显示的提示框的样式
- (instancetype)init {
    if (self = [super init]) {
        
        // 1.
        self.undermostBackgroundControl = [[UIControl alloc] initWithFrame:SharedApplication.keyWindow.bounds];
        self.undermostBackgroundControl.backgroundColor = [UIColor clearColor];
        self.undermostBackgroundControl.alpha = 0;
        
        self.messageView = [[UIView alloc] init];
        self.messageView.width = 200;
        self.messageView.height = 70;
        self.messageView.center = SharedApplication.keyWindow.center;
        self.messageView.layer.cornerRadius = 5;
        self.messageView.clipsToBounds = YES;
        self.messageView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1];
        self.messageView.alpha = 0.5;
        
        self.messageLabel = [[UILabel alloc] init];
        //self.messageLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-200, 300, 200, 70);
        self.messageLabel.left = 10;
        self.messageLabel.width = 180;
        self.messageLabel.height = 70;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.textColor = [UIColor blackColor];
        self.messageLabel.font = [UIFont boldSystemFontOfSize:15.0];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.backgroundColor = [UIColor clearColor];
        [self.messageView addSubview:self.messageLabel];
        
        
        // 2.
        self.netAlertControl = [[UIControl alloc] initWithFrame:SharedApplication.keyWindow.bounds];
        self.netAlertControl.backgroundColor = [UIColor clearColor];
        self.netAlertControl.userInteractionEnabled = NO;
        
        
        self.netAlertView = [[UIView alloc] init];
        self.netAlertView.width = 200;
        self.netAlertView.height = 70;
        self.netAlertView.center = SharedApplication.keyWindow.center;
        self.netAlertView.layer.cornerRadius = 5;
        self.netAlertView.clipsToBounds = YES;
        self.netAlertView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1];
        self.netAlertView.alpha = 0;
        
        self.netAlertActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.netAlertActivityIndicatorView.frame = CGRectMake(30, 35-5, 10, 10);
        self.netAlertActivityIndicatorView.hidesWhenStopped = YES;
        [self.netAlertActivityIndicatorView stopAnimating];
        [self.netAlertView addSubview:self.netAlertActivityIndicatorView];
        
        self.netAlertLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 150, 70)];
        self.netAlertLabel.textColor = [UIColor whiteColor];
        self.netAlertLabel.numberOfLines = 0;
        self.netAlertLabel.textAlignment = NSTextAlignmentCenter;
        self.netAlertLabel.backgroundColor = [UIColor clearColor];
        [self.netAlertView addSubview:self.netAlertLabel];
        
    }
    
    return self;
}

#pragma mark - public

- (void)showAlertMessage:(NSString *)message {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [SharedApplication.keyWindow addSubview:self.messageView];
    self.messageLabel.text = message;
    self.messageView.transform = CGAffineTransformMakeScale(kTransformAppearingScale, kTransformAppearingScale);
    
    [UIView animateWithDuration:kAnimationDuration//放大持续0.3-改成0.2
                          delay:0
                        options:7 << 16
                     animations:^{
        self.messageView.transform = CGAffineTransformIdentity;
        self.messageView.alpha = 0.98;
        
    } completion:nil];
    //显示1.6-0.3*2s = 1s改成 1.0-0.2*2 = 0.6s
    [self performSelector:@selector(hideAlertMessage) withObject:nil afterDelay:1.0];
    
}

- (void)hideAlertMessage {
    
    [UIView animateWithDuration:kAnimationDuration//缩小持续0.3-改成0.2
                          delay:0
                        options:7 << 16
                     animations:^{
        
        self.messageView.transform = CGAffineTransformMakeScale(kTransformDisappearingScale, kTransformDisappearingScale);
        self.messageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.messageView removeFromSuperview];
    }];
}





////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

- (void)showLoadingAlertMessage:(NSString *)message viewController:(UIViewController *)viewController{
    
    for (UIView *view in viewController.view.subviews) {
        view.userInteractionEnabled = NO;
    }
    
//    for (UIView *view in viewController.navigationController.navigationBar.subviews) {
//        view.userInteractionEnabled = NO;
//    }
    
    self.netAlertLabel.frame = CGRectMake(40, 0, 150, 70);
    [SharedApplication.keyWindow addSubview:self.netAlertControl];
    
    [SharedApplication.keyWindow addSubview:self.netAlertView];
    
    self.netAlertLabel.text = message;
    [self.netAlertActivityIndicatorView startAnimating];
    self.netAlertView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
                        options:7 << 16
                     animations:^{
        
        self.netAlertView.transform = CGAffineTransformIdentity;
        self.netAlertView.alpha = 0.66;
        
    } completion:nil];
    
}

- (void)dismissLoadingAlertMessage:(NSString *)message viewController:(UIViewController *)viewController {
    
    self.devViewController = viewController;
    
    if (message != nil) {
        self.netAlertLabel.text = message;
        
        // fish经常犯的一个错误就是忽视了子view是放在父view上的，所以坐标没有相对父view去写
        
        self.netAlertLabel.frame = CGRectMake(10, 0, 180, 70);
        
        [self.netAlertActivityIndicatorView stopAnimating];
        
        [self performSelector:@selector(hideLoadingAlert) withObject:nil afterDelay:0.8];
        
        return;
    }
    
    [self hideAlertWithViewController:viewController];
}

- (void)hideLoadingAlert {
    [self hideAlertWithViewController:self.devViewController];
}

- (void)hideAlertWithViewController:(UIViewController *)viewController {
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
                        options:7 << 16
                     animations:^{
                         
                         self.netAlertView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                         self.netAlertView.alpha = 0;
                         
                     } completion:^(BOOL finished) {
                         
                         
                         for (UIView *view in viewController.view.subviews) {
                             view.userInteractionEnabled = YES;
                         }
                         
//                         for (UIView *view in viewController.navigationController.navigationBar.subviews) {
//                             view.userInteractionEnabled = YES;
//                         }
                         
                         [self.netAlertView removeFromSuperview];
                         [self.netAlertControl removeFromSuperview];
                         
                     }];
}

@end
