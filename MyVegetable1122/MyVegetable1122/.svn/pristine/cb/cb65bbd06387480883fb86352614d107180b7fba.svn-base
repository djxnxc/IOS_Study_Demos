//




//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    JAlertIconTypeNone,
    JAlertIconTypeSuccess,
    JAlertIconTypeError
} JAlertIconType;

@interface JAlertManager : NSObject
@property (nonatomic, strong) UIControl *netAlertControl;

@property (nonatomic, strong)UIView *netAlertView;
@property (nonatomic, strong) UIActivityIndicatorView *netAlertActivityIndicatorView;
@property (nonatomic, strong) UILabel *netAlertLabel;


+ (instancetype)sharedAlertManager;

#pragma mark - 1.
- (void)showAlertMessage:(NSString *)message;

#pragma mark - 2.

- (void)showLoadingAlertMessage:(NSString *)message viewController:(UIViewController *)viewController;
- (void)dismissLoadingAlertMessage:(NSString *)message viewController:(UIViewController *)viewController;

@end
