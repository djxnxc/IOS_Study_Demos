//
//  CCProgressView.m
//  ProgressViewDemo
//
//  

#import "DrowCircle.h"
#import "UICountingLabel.h"
#define jradius 0.08  //同另外一个一样大小
#define  ViewHeight [[UIScreen mainScreen] bounds].size.height
#define  ViewWidth [[UIScreen mainScreen] bounds].size.width

@interface DrowCircle()
{
    UIColor *_currentWaterColor;
    
    float _currentLinePointY;
    
    float a;
    float b;
    
    BOOL jia;
    
}
@end

@implementation DrowCircle

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer*)self.layer;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        CGFloat startAngle =0;
        CGFloat endAngle = 360;
        
        //        MIN(rect.size.width, rect.size.height) / 2.0f;
        _lineWidth = [NSNumber numberWithFloat:15.0];
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2,frame.size.height/2) radius:(self.frame.size.height * 0.5-self.frame.size.height*jradius/2) startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:YES];
        
        _circleBG             = [CAShapeLayer layer];
        _circleBG.path        = circlePath.CGPath;
        _circleBG.lineCap     = kCALineCapRound;
        _circleBG.fillColor   = [UIColor clearColor].CGColor;
        _circleBG.strokeColor=[UIColor redColor].CGColor;
        _circleBG.lineWidth   = 0;
       
        _circleBG.strokeColor = [UIColor lightGrayColor].CGColor;
        _circleBG.zPosition   = -1;
        
        
//                [self.layer addSublayer:_circleBG];

        
        
        CAShapeLayer* maskLayer = [CAShapeLayer layer];
        maskLayer.path = circlePath.CGPath;
        self.gradientLayer.mask = maskLayer;
      
        self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:250/255.0f green:113/255.0f blue:106/255.0f alpha:1]CGColor],(id)[[UIColor colorWithRed:250/255.0f green:113/255.0f blue:106/255.0f alpha:1]CGColor], nil];

        
        self.gradientLayer.startPoint =CGPointMake(0.5, 1);
        self.gradientLayer.endPoint = CGPointMake(0.5, 0);
        

        
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    CGFloat rescaledProgress = MIN(MAX(progress, 0.f), 1.f);
    NSArray* newLocations =@[[NSNumber numberWithFloat:rescaledProgress], [NSNumber numberWithFloat:rescaledProgress]];
    
    if (animated)
    {
        NSTimeInterval duration = 0.5;
        [UIView animateWithDuration:duration animations:^{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = duration;
            animation.delegate = self;
            animation.fromValue = self.gradientLayer.locations;
            animation.toValue = newLocations;
//            [self.gradientLayer addAnimation:animation forKey:@"animateLocations"];
        }];
    }
    else
    {
        [self.gradientLayer setNeedsDisplay];
    }
    
    self.gradientLayer.locations = newLocations;
    a = 1.5;
    b = 0;
    jia = NO;
    _currentLinePointY = self.frame.size.height*(1-progress);
    _currentWaterColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
    //_currentLinePointY = 250;
    if(_theTimer)
    {
        [_theTimer invalidate];
        _theTimer=nil;
    }
//    _theTimer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
    
    
}



- (void)drawRect:(CGRect)rect {
//{
//    self.layer.shadowOffset = CGSizeMake(15, 15); //设置阴影的偏移量
//    self.layer.shadowRadius = 3.0;  //设置阴影的半径
//    self.layer.shadowColor = RGB_gray.CGColor; //设置阴影的颜色为黑色
//    self.layer.shadowOpacity = 0.8; //透明度

    
    
}

@end