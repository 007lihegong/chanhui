//
//  UIButton+CountDown.m
//  倒计时
//
//  Created by lanou3g on 16/1/5.
//  Copyright © 2016年 syx. All rights reserved.
//

#import "UIButton+CountDown.h"
#import "Defines.h"

@implementation UIButton (CountDown)


- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{

    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
       
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:mainLan forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
        
            int seconds = (int)timeOut;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitleColor:color(153, 153, 153, 1) forState:UIControlStateNormal];
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

- (void)skipWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = (int)timeOut;
            NSString * timeStr = [NSString stringWithFormat:@"%d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}




@end
