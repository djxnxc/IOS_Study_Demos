//
//  UULineChart.m
//  UUChartDemo
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UULineChart.h"
#import "UUColor.h"
#import "UUChartLabel.h"

#define BOTTOM_MARGIN_TO_LEAVE 30.0

@implementation UULineChart {
    NSHashTable *_chartLabelsForX;
    CGPoint  _xPosition;
    SHPlot  *_plots;
    CGFloat  _leftMarginToLeave;
    NSArray *_xAxisValues;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}
#pragma mark - 横线
-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    NSInteger min = 1000000000;

    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            NSInteger value = [valueString integerValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (max < _LinePointNum) {
        max = _LinePointNum;
    }
    if (self.showRange) {
        _yValueMin = min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = (CGFloat)max;
    
    if (_chooseRange.max!=_chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
//    _yValueMax 最大数值
    float level = (_yValueMax-_yValueMin) /(CGFloat)(_LinePointNum - 1);
    //底部的横线的Y值。减去顶部的一个labelH和底部的两个labelH
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    //两个横线间距
    CGFloat levelHeight = chartCavanHeight /(CGFloat)(_LinePointNum - 1);

    //label 下面的5是label往Y方向的偏移值 ，便于移到center位置
    for (int i=0; i<_LinePointNum; i++) {
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight-i*levelHeight+5, UUYLabelwidth, UULabelHeight)];
		label.text = [NSString stringWithFormat:@"%.2lf",(CGFloat)(level * i+_yValueMin)];
        label.backgroundColor = [UIColor clearColor];
        
//        label.hidden = i%2?NO:YES;
//        if (i==0) {
//            label.hidden= NO;
//        }
		[self addSubview:label];
        
    }
    
//    //画标记数值的区域
//    if ([super respondsToSelector:@selector(setMarkRange:)]) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(UUYLabelwidth, (1-(_markRange.max-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight+UULabelHeight, self.frame.size.width-UUYLabelwidth, (_markRange.max-_markRange.min)/(_yValueMax-_yValueMin)*chartCavanHeight)];
//        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
//        [self addSubview:view];
//    }

    //画横线
    for (int i=0; i<_LinePointNum; i++) {
        if (_LinePointNum == i) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(UUYLabelwidth,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width,UULabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            if(i == _LinePointNum){
                shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];//竖线颜色。
                shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
                shapeLayer.lineWidth = 1;//线颜色。
            }
            else{
                shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];//竖线颜色。
                shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
                shapeLayer.lineWidth = 0.8;//线颜色。
            }
            [self.layer addSublayer:shapeLayer];
            
            return;
        }
        if ([_ShowHorizonLine[i] integerValue]>0) {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(UUYLabelwidth,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width,UULabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
//            if (i==3) {
//                return;
//            }
//            if (i == 0) {
//                shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];//竖线颜色。
//                shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
//                shapeLayer.lineWidth = 1;//线颜色。
//            }
//            else
                if(i == _LinePointNum-1){
                shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];//竖线颜色。
                shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
                shapeLayer.lineWidth = 1;//线颜色。
            }
            else{
                shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];//竖线颜色。
                shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
                shapeLayer.lineWidth = 0.8;//线颜色。
            }
            [self.layer addSublayer:shapeLayer];
        }
    }
}
#pragma mark 竖线
-(void)setXLabels:(NSArray *)xLabels
{
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    
    _xLabels = xLabels;
    CGFloat num = 0;
    if (xLabels.count>=20) {
        num=20.0;
    }else if (xLabels.count<=1){
        num=1.0;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = (self.frame.size.width - UUYLabelwidth)/num;
    
    for (int i=0; i<xLabels.count+1; i++) {
        NSString *labelText;
        if (i == xLabels.count) labelText = @"";
        else  labelText = xLabels[i];
        
        UUChartLabel * label = [[UUChartLabel alloc] initWithFrame:CGRectMake(_xLabelWidth/2+i * _xLabelWidth+UUYLabelwidth, self.frame.size.height - UULabelHeight, _xLabelWidth, UULabelHeight)];
        label.text = labelText;
         label.backgroundColor = [UIColor clearColor];
        
        [self addSubview:label];
        label.textAlignment = 1;
        [_chartLabelsForX addObject:label];
    }
    
    
    //画竖线
    for (int i=0; i<xLabels.count+1; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        if (i == 0) {//第一个线
            [path moveToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,UULabelHeight)];
            [path addLineToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,self.frame.size.height-2*UULabelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];//竖线颜色。
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;//竖线颜色。
            
        }else{
            [path moveToPoint:CGPointMake(UUYLabelwidth+(i)*_xLabelWidth,UULabelHeight)];
            [path addLineToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,self.frame.size.height-2*UULabelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];//竖线颜色。
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 0.5;
        }
        
        
        [self.layer addSublayer:shapeLayer];
    }
}

-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}

- (void)setMarkRange:(CGRange)markRange
{
    _markRange = markRange;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}

- (void)setShowHorizonLine:(NSMutableArray *)ShowHorizonLine
{
    _ShowHorizonLine = ShowHorizonLine;
}

#pragma mark  画线
-(void)strokeChart
{
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count==0) {
            return;
        }
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        NSInteger max_i;
        NSInteger min_i;
        
        for (int j=0; j<childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 2.0;
        _chartLine.strokeEnd   = 0.0;
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        CGFloat xPosition = (UUYLabelwidth+(1)*_xLabelWidth);
        CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
        
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
       
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        if (self.ShowMaxMinArray) {
            if ([self.ShowMaxMinArray[i] intValue]>0) {
                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?NO:YES;
            }else{
                isShowMaxAndMinPoint = YES;
            }
        }
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)
                 index:i
                isShow:isShowMaxAndMinPoint
                 value:firstValue];

        
        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in childAry) {
            
            float grade =([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0) {
                
                CGPoint point = CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight+UULabelHeight);
                [progressline addLineToPoint:point];
                
                BOOL isShowMaxAndMinPoint = YES;
                if (self.ShowMaxMinArray) {
                    if ([self.ShowMaxMinArray[i] intValue]>0) {
                        isShowMaxAndMinPoint = (max_i==index || min_i==index)?NO:YES;
                    }else{
                        isShowMaxAndMinPoint = YES;
                    }
                }
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                        isShow:isShowMaxAndMinPoint
                         value:[valueString floatValue]];
                
//                [progressline stroke];
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        if ([[_colors objectAtIndex:i] CGColor]) {
            _chartLine.strokeColor = [[_colors objectAtIndex:i] CGColor];
        }else{
            _chartLine.strokeColor = [self.color CGColor];
        }
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.4;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
    }
    [self setupTheView];
}

- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(CGFloat)value
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 8, 8)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    view.layer.borderWidth = 2;
    view.layer.borderColor = RGB_red_alph6.CGColor;//红圈圈的颜色
    
    if (isHollow) {
        view.backgroundColor = [UIColor whiteColor];
    }else{
        view.backgroundColor = [_colors objectAtIndex:index]?[_colors objectAtIndex:index]:self.color;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-UUTagLabelwidth/2.0, point.y-UULabelHeight*2, UUTagLabelwidth, UULabelHeight)];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = view.backgroundColor;
        label.text = [NSString stringWithFormat:@"%d",(int)value];
        [self addSubview:label];
    }
    
    [self addSubview:view];
    
    
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}



#pragma mark - 阴影区域

- (void)setupTheView
{
    _plots.plottingValues = @[
                              @{ @1 : @65.8 },
                              @{ @2 : @20 },
                              @{ @3 : @23 },
                              @{ @4 : @22 },
                              @{ @5 : @12.3 }
                             
                              ];
    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5"];
    _plots.plottingPointsLabels = arr;
    
    _leftMarginToLeave = UUYLabelwidth+_xLabelWidth;
    
    _xAxisValues =  @[
                                   @{ @1 : @"JAN" },
                                   @{ @2 : @"FEB" },
                                   @{ @3 : @"MAR" },
                                   @{ @4 : @"APR" },
                                   @{ @5 : @"MAY" }
                                   ];
    
    for(SHPlot *plot in _plots) {
        [self drawPlot:plot];
    }
}

- (void)drawPlot:(SHPlot *)plot {
    
    long  PLOT_WIDTH  = (self.bounds.size.width - _leftMarginToLeave);
    
    //背景填充色
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.fillColor = ([UIColor redColor]).CGColor;
    backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
    [backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
    [backgroundLayer setLineWidth:(@2).intValue];
    
    CGMutablePathRef backgroundPath = CGPathCreateMutable();
    
    // _yAxisRange最大的坐标值
    double yRange = _yValueMax; // this value will be in dollars
    double yIntervalValue = yRange / 4;//y的间隔值
    
    //logic to fill the graph path, ciricle path, background path.
    // plot.plottingValues   _yValues y值集合
    [_yValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
        
        int xIndex = [self getIndexForValue:_key forPlot:plot];
        
        //x value
        double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
        double y = height - ((height / ([_yAxisRange doubleValue] + yIntervalValue)) * [_value doubleValue]);
        (plot.xPoints[xIndex]).x = ceil((plot.xPoints[xIndex]).x);
        (plot.xPoints[xIndex]).y = ceil(y);
    }];
    
    CGPathMoveToPoint(backgroundPath, NULL, _leftMarginToLeave, plot.xPoints[0].y);
    int count = _yValues.count;
    for(int i=0; i< count; i++){
        CGPoint point = plot.xPoints[i];
        CGPathAddLineToPoint(backgroundPath, NULL, point.x, point.y);
    }
    CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave + PLOT_WIDTH, self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE);
    CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave, self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE);
    CGPathCloseSubpath(backgroundPath);
    
    backgroundLayer.path = backgroundPath;
    backgroundLayer.zPosition = 0;
    [self.layer addSublayer:backgroundLayer];
}
- (int)getIndexForValue:(NSNumber *)value forPlot:(SHPlot *)plot {
    for(int i=0; i< _yValues.count; i++) {
        NSDictionary *d = [_xAxisValues objectAtIndex:i];
        __block BOOL foundValue = NO;
        [d enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSNumber *k = (NSNumber *)key;
            if([k doubleValue] == [value doubleValue]) {
                foundValue = YES;
                *stop = foundValue;
            }
        }];
        if(foundValue){
            return i;
        }
    }
    return -1;
}





@end
