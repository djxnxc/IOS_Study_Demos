//
//  ZendaiAlterview.m
//  new


#import "ZendaiAlertView.h"
// 设置警告框的长和宽

#define Alertwidth 290.0f
#define widthAlertwidth 300.0f
//#define Alertheigth 150.0f
#define Zendaititlegap 15.0f
#define Zendaititleofheigth 25.0f
#define ZendaiSinglebuttonWidth 160.0f
//        单个按钮时的宽度
#define ZendaidoublebuttonWidth 100.0f
//        双个按钮的宽度
#define ZendaibuttonHeigth 35.0f
//        按钮的高度
#define Zendaibuttonbttomgap 10.0f
//        设置按钮距离底部的边距

#define ZendaibuttontagLeft 13
#define Zendaibuttontagright 14
#define Zendaibuttontagline 15
@interface ZendaiAlertView ()
{
    BOOL _leftLeave;
    CGFloat Alertheigth;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftbtn;
@property (nonatomic, strong) UIButton *rightbtn;
@property (nonatomic, strong) UIView *backimageView;

@end

@implementation ZendaiAlertView



+ (CGFloat)alertWidth
{
    return Alertwidth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        Alertheigth=150.0f;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;//阴影颜色
        self.layer.shadowOffset = CGSizeMake(0.1, 0.2);//偏移距离
        self.layer.shadowOpacity = 0.5;//不透明度
        self.layer.shadowRadius = 2;//半径
    }
    return self;
}
+(ZendaiAlertView*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle
{
    ZendaiAlertView *alert = [[ZendaiAlertView alloc] initWithTitle:message contentText:subtitle leftButtonTitle:nil rightButtonTitle:cancle];
    [alert show];
    alert.rightBlock = ^() {
       
    };
    alert.dismissBlock = ^() {
       
    };
    return alert;
}

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        
        CGFloat contentLabelWidth = Alertwidth - 16-20;
        UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
        CGSize size = CGSizeMake(contentLabelWidth,2000);
        CGSize labelsize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        
        Alertheigth=labelsize.height>60?((labelsize.height-60)+Alertheigth):Alertheigth;
        
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Zendaititlegap, Alertwidth, Zendaititleofheigth)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        self.alertTitleLabel.textColor=[UIColor redColor];
        [self addSubview:self.alertTitleLabel];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, self.alertTitleLabel.frame.size.height +self.alertTitleLabel.frame.origin.y+5, Alertwidth, 0.5)];
        view.backgroundColor=[UIColor orangeColor];
        [self addSubview:view];
        
//        _alertTitleLabel.backgroundColor = RGB_black;
//        _alertContentLabel.backgroundColor = RGB_gray;
        
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((Alertwidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame)+10, contentLabelWidth, 60)];
        self.alertContentLabel.frame=CGRectMake((Alertwidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame)+4, contentLabelWidth, labelsize.height>60?labelsize.height:60);
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        self.alertContentLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:self.alertContentLabel];
        //        设置对齐方式
        self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        CGRect leftbtnFrame;
        CGRect rightbtnFrame;

        if (!leftTitle) {
            rightbtnFrame = CGRectMake((Alertwidth - ZendaiSinglebuttonWidth) * 0.5, Alertheigth - Zendaibuttonbttomgap - ZendaibuttonHeigth, ZendaiSinglebuttonWidth, ZendaibuttonHeigth);
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn.frame = rightbtnFrame;
            
        }else {
            leftbtnFrame = CGRectMake((Alertwidth - 2 * ZendaidoublebuttonWidth - Zendaibuttonbttomgap) * 0.5, Alertheigth - Zendaibuttonbttomgap - ZendaibuttonHeigth, ZendaidoublebuttonWidth, ZendaibuttonHeigth);
            
            rightbtnFrame = CGRectMake(CGRectGetMaxX(leftbtnFrame) + Zendaibuttonbttomgap, Alertheigth - Zendaibuttonbttomgap - ZendaibuttonHeigth, ZendaidoublebuttonWidth, ZendaibuttonHeigth);
            self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftbtn.frame = leftbtnFrame;
            self.rightbtn.frame = rightbtnFrame;
        }
       
        [self.rightbtn setBackgroundColor:[UIColor redColor]];
        [self.leftbtn setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]];
        [self.rightbtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftbtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftbtn.titleLabel.font = self.rightbtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.leftbtn addTarget:self action:@selector(leftbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightbtn addTarget:self action:@selector(rightbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftbtn.layer.masksToBounds = self.rightbtn.layer.masksToBounds = YES;
        self.leftbtn.layer.cornerRadius = self.rightbtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftbtn];
        [self addSubview:self.rightbtn];
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        
        
        view.hidden = YES;
        view.tag = Zendaibuttontagline;
        self.leftbtn.tag = ZendaibuttontagLeft;
        self.rightbtn.tag = Zendaibuttontagright;
        self.cha = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cha setImage:[UIImage imageNamed:@"dissmissX"] forState:UIControlStateNormal];
        self.cha.frame=CGRectMake(CGRectGetMaxX(_alertContentLabel.frame)-20, CGRectGetMidY(_alertTitleLabel.frame)-12/2-2,12, 12);
        [self addSubview:self.cha];//与title同中心
        [self.cha addTarget:self action:@selector(dis) forControlEvents:UIControlEventTouchUpInside];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
        contentText:(NSMutableAttributedString *)content
      textAlignment:(NSTextAlignment)textAlignment
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        
        CGFloat contentLabelWidth = Alertwidth - 20;
        UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
        CGSize size = CGSizeMake(contentLabelWidth,2000);
        CGSize labelsize = [content.string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        
        Alertheigth=labelsize.height>60?((labelsize.height-60)+Alertheigth):Alertheigth;
        
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Zendaititlegap, Alertwidth, Zendaititleofheigth)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        self.alertTitleLabel.textColor=[UIColor redColor];
        [self addSubview:self.alertTitleLabel];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, self.alertTitleLabel.frame.size.height +self.alertTitleLabel.frame.origin.y+5, Alertwidth, 0.6)];
        view.backgroundColor=[UIColor orangeColor];
        [self addSubview:view];
        
        
        
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((Alertwidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame)+10, contentLabelWidth, 60)];
        self.alertContentLabel.frame=CGRectMake((Alertwidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame)+10, contentLabelWidth, labelsize.height>60?labelsize.height:60);
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        self.alertContentLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:self.alertContentLabel];
        
        
        
        //        设置对齐方式
        
        CGRect leftbtnFrame;
        CGRect rightbtnFrame;
        
        if (!leftTitle) {
            rightbtnFrame = CGRectMake((Alertwidth - ZendaiSinglebuttonWidth) * 0.5, Alertheigth - Zendaibuttonbttomgap - ZendaibuttonHeigth, ZendaiSinglebuttonWidth, ZendaibuttonHeigth);
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn.frame = rightbtnFrame;
            
        }else {
            leftbtnFrame = CGRectMake((Alertwidth - 2 * ZendaidoublebuttonWidth - Zendaibuttonbttomgap) * 0.5, Alertheigth - Zendaibuttonbttomgap - ZendaibuttonHeigth, ZendaidoublebuttonWidth, ZendaibuttonHeigth);
            
            rightbtnFrame = CGRectMake(CGRectGetMaxX(leftbtnFrame) + Zendaibuttonbttomgap, Alertheigth - Zendaibuttonbttomgap - ZendaibuttonHeigth, ZendaidoublebuttonWidth, ZendaibuttonHeigth);
            self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftbtn.frame = leftbtnFrame;
            self.rightbtn.frame = rightbtnFrame;
        }
        
        [self.rightbtn setBackgroundColor:[UIColor redColor]];
        [self.leftbtn setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]];
        [self.rightbtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftbtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftbtn.titleLabel.font = self.rightbtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.leftbtn addTarget:self action:@selector(leftbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightbtn addTarget:self action:@selector(rightbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftbtn.layer.masksToBounds = self.rightbtn.layer.masksToBounds = YES;
        self.leftbtn.layer.cornerRadius = self.rightbtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftbtn];
        [self addSubview:self.rightbtn];
        self.alertTitleLabel.text = title;
        self.alertContentLabel.attributedText = content;
        
        self.alertContentLabel.textAlignment =textAlignment;
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;

        
        view.hidden = YES;
        view.tag = Zendaibuttontagline;
        self.leftbtn.tag = ZendaibuttontagLeft;
        self.rightbtn.tag = Zendaibuttontagright;
        UIButton *cha = [UIButton buttonWithType:UIButtonTypeCustom];
        [cha setImage:[UIImage imageNamed:@"dissmissX"] forState:UIControlStateNormal];
        cha.frame=CGRectMake(CGRectGetMaxX(_alertContentLabel.frame)-20, CGRectGetMidY(_alertTitleLabel.frame)-12/2-2,12, 12);
        [self addSubview:cha];//与title同中心
        [cha addTarget:self action:@selector(dis) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}
- (void)dis {
    [self dismissAlert];
}
- (void)leftbtnclicked:(id)sender
{
    
    if (self.leftBlock) {
        self.leftBlock();
    }
    [self dismissAlert];
}

- (void)rightbtnclicked:(id)sender
{
    
    if (self.rightBlock) {
        self.rightBlock();
    }
//    [self dismissAlert];
}
-(void)setLeftColor:(UIColor *)leftColor {
    for (UIView *v  in self.subviews) {
        if (v.tag == ZendaibuttontagLeft) {
            UIButton *btn = (UIButton *)v;
            [btn setBackgroundColor:leftColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}
- (void)setRightColor:(UIColor *)rightColor {
    for (UIView *v  in self.subviews) {
        if (v.tag == Zendaibuttontagright) {
            UIButton *btn = (UIButton *)v;
            [btn setBackgroundColor:rightColor];
        }
    }
}
- (void)setShowLine:(BOOL)showLine {
    
    for (UIView *v  in self.subviews) {
        if (v.tag == Zendaibuttontagright) {
            v.hidden = showLine;
        }
    }
   
}
- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5-30, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5-20, Alertwidth, Alertheigth);
//    self.alpha=0;
    [self shakeToShow:self];
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperviewi];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{

    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperviewi
{
  
    [self.backimageView removeFromSuperview];
    self.backimageView = nil;
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self shakeToShow:self];
//        self.frame = afterFrame;
//        self.alpha=0;
    } completion:^(BOOL finished) {
        

        [super removeFromSuperview];
    
        
    }];
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backimageView) {
        self.backimageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backimageView.backgroundColor = [UIColor blackColor];
        self.backimageView.alpha = 0.5f;
        self.backimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backimageView];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5, Alertwidth, Alertheigth);
    self.frame = afterFrame;
    
//    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.frame = afterFrame;
////        self.alpha=0.9;
//    } completion:^(BOOL finished) {
//    }];
    [super willMoveToSuperview:newSuperview];
}


- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}


@end
