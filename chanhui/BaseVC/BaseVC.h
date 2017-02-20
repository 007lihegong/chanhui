//
//  BaseVC.h
//  kuangjia
//
//  Created by 名侯 on 16/8/15.
//  Copyright © 2016年 侯彦名. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "XYString.h"
#import "Defines.h"
#import "UIView+XBExtension.h"
#import "LCProgressHUD.h"
#import "MJExtension.h"
#import <UIView+SDAutoLayout.h>

@interface BaseVC : UIViewController
{
    AppDelegate *appdelegate;
}

//自定义导航栏
- (UIView *)setNav:(NSString *)string add:(UIView *)view;
//自定义导航栏标题
- (void)configureTitleView;
//自定义返回按钮
- (void)configureLeft:(NSString *)string;
//自定义导航栏右边按钮--文字
- (void)configureRight:(NSString *)string;
//自定义导航栏右边按钮--图片
- (void)configureRightImage:(NSString *)imgName;
//导航栏右边点击事件
- (void)rightNavAction;
//返回的点击事件
- (void)backNavAction;
//设置边框
-(void)setBorder:(UIView *)view size:(float)size;
//设置边框+颜色
-(void)setBorder:(UIView *)view size:(float)size withColor:(UIColor *)color;
//设置成圆形
-(void) setYuan:(UIView *)view size:(double)size;
//阴影
- (void)setshadow:(UIView *)view;
//阴影自定义
- (void)setshadow:(UIView *)view scope:(CGFloat)width transparent:(CGFloat)alpha direction:(CGSize)size;
//生产1像素的线
- (void)PixeOrigin:(CGPoint)origin length:(CGFloat)length isVertical:(BOOL)isVertical color:(UIColor *)color add:(UIView *)supview;
//生产水平线
- (void)PixeH:(CGPoint)origin lenght:(CGFloat)length add:(UIView *)supview;
//生产垂直线
- (void)PixeV:(CGPoint)origin lenght:(CGFloat)length add:(UIView *)supview;
//存值
- (void)setUserifon:(id)value andKey:(NSString *)key;

#pragma mark -- AFN网络请求
- (void)post:(NSString *)URLString parameters:(NSMutableDictionary *)parameters show:(BOOL)loading success:(void (^)(id))success failure:(void (^)(NSError *))failure;
#pragma mark -----------------  项目中定义
- (UIButton *)setMainButton:(NSString *)string add:(UIView *)view setY:(CGFloat)btY;
- (void)mainButtonAction;
//Lable
- (UILabel *)setLable:(CGRect)rect setText:(NSString *)text setTextColor:(UIColor *)color setFont:(UIFont *)font addView:(UIView *)view;

//上传图片
- (void)postImg:(NSString *)URLString parameters:(id)parameters sendImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
