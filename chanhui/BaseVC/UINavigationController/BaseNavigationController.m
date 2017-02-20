/*!
 @header BaseNavigationController.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/1/19
 
 @version 1.00 16/1/19 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import "BaseNavigationController.h"
#import "Defines.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if( ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)) {
        self.edgesForExtendedLayout=UIRectEdgeNone;//下移64
        self.navigationBar.translucent = NO;
    }
    self.navigationBar.barTintColor = mainHong;
    //返回按钮颜色
    UIImage *backButtonImage = [[UIImage imageNamed:@"navigator_btn_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17.0],NSFontAttributeName ,nil];
    
    //滑动返回手势
    __weak BaseNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
    //加阴影
    [self setshadow:self.navigationBar scope:1 transparent:0.3 direction:CGSizeMake(0, 1)];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/**
 *  导航控制器 统一管理状态栏颜色
 *  @return 状态栏颜色
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

//阴影自定义
- (void)setshadow:(UIView *)view scope:(CGFloat)width transparent:(CGFloat)alpha direction:(CGSize)size {
    
    view.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    view.layer.shadowOffset = CGSizeMake(size.width, size.height);//阴影方向
    view.layer.shadowOpacity = alpha;//阴影透明度
    view.layer.shadowRadius = width;//阴影范围
}

@end
