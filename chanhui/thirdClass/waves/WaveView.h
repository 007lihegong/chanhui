//
//  WaveView.h
//  WaveAnimation
//
//  Created by ymm_iMac on 2017/2/6.
//  Copyright © 2017年 HR_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView
/**
 *  The speed of wave 波浪的快慢
 */
@property (nonatomic,assign)CGFloat waveSpeed;

/**
 *  The amplitude of wave 波浪的震荡幅度
 */
@property (nonatomic,assign)CGFloat waveAmplitude; // 波浪的震荡幅度


/**
 *  Start waving
 */
- (void)wave;

/**
 *  Stop waving
 */
- (void)stop;
@end
