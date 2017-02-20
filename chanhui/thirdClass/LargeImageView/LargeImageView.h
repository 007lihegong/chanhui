//
//  LargeImageView.h
//  lisong
//
//  Created by 李松 on 15/10/16.
//  Copyright © 2015年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargeImageView : UIView

- (instancetype)initWithView:(UIView *)view image:(UIImage *)image imageUrl:(NSString *)url;

- (void)show;

@end
