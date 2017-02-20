//
//  WaveView.m
//  WaveAnimation
//
//  Created by ymm_iMac on 2017/2/6.
//  Copyright © 2017年 HR_iMac. All rights reserved.
//

#import "WaveView.h"

@interface WaveView  () {
    CGFloat waterWaveWidth;
    CGFloat waterWaveHeight;
    
    CGFloat offsetX;
    
    CADisplayLink *waveDisplaylink;
    CAShapeLayer  *waveLayer;
    UIBezierPath *waveBoundaryPath;
}

@end

@implementation WaveView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        waterWaveWidth = frame.size.width;
        waterWaveHeight = frame.size.height * 0.5;
    }
    return self;
}


- (void)wave {
    waveBoundaryPath = [UIBezierPath bezierPath];
    
    waveLayer = [CAShapeLayer layer];
    waveLayer.fillColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:0.3].CGColor;
    [self.layer addSublayer:waveLayer];
    waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop {
    [waveDisplaylink invalidate];
    waveDisplaylink = nil;
}



- (void)getCurrentWave:(CADisplayLink *)displayLink {
    offsetX += self.waveSpeed;
    waveBoundaryPath = [self getgetCurrentWavePath];
    waveLayer.path = waveBoundaryPath.CGPath;
}

- (UIBezierPath *)getgetCurrentWavePath {
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, waterWaveHeight);
    CGFloat y = 0.0f;
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        //调整波浪的形状
        y = self.waveAmplitude* sinf((360/waterWaveWidth) *(x * M_PI / 360) - offsetX * M_PI / 360) + waterWaveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    p.CGPath = path;
    CGPathRelease(path);
    return p;
}




@end
