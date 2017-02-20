//
//  RootTabBarController.m
//  WMVideoPlayer
//
//  Created by 郑文明 on 15/12/14.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "RootTabBarController.h"
#import "Defines.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"

#import "HomeVC.h"
#import "ProductVC.h"
#import "MyVC.h"

@interface RootTabBarController () <UITabBarControllerDelegate>

@property (nonatomic ,strong) UILabel *lineLB;

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    HomeVC *tencentVC = [[HomeVC alloc]init];
    tencentVC.title = @"首页";
    BaseNavigationController *tencentNav = [[BaseNavigationController alloc]initWithRootViewController:tencentVC];
    tencentNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"tab_home"] selectedImage:[UIImage imageNamed:@"tab_home"]];

    ProductVC *sinaVC = [[ProductVC alloc]init];
    sinaVC.title = @"Fire";
    BaseNavigationController *sinaNav = [[BaseNavigationController alloc]initWithRootViewController:sinaVC];
    sinaNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Fire" image:[UIImage imageNamed:@"tab_product"] selectedImage:[UIImage imageNamed:@"tab_product"]];
    
    MyVC *netEaseVC = [[MyVC alloc]init];
    netEaseVC.title = @"我的";
    BaseNavigationController *netEaseNav = [[BaseNavigationController alloc]initWithRootViewController:netEaseVC];
    netEaseNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"tab_my"] selectedImage:[UIImage imageNamed:@"tab_my"]];
    
    self.viewControllers = @[tencentNav,sinaNav,netEaseNav];
    self.tabBar.tintColor = mainHong;
    
    //KVO
//    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:NULL];
    
    //背景色
//    self.tabBar.barTintColor = [UIColor blueColor];
    //字颜色的设置
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
//    [self.tabBar setClipsToBounds:YES];
//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 1)];
//    line.backgroundColor = mainHuang;
//    self.lineLB = line;
//    [self.tabBar addSubview:line];
    
}

#pragma mark -- 观察者模式的代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
//    if (object == self && [keyPath isEqualToString:@"selectedIndex"]) {
//        NSLog(@"属性＝%@",change);
//        self.lineLB.x = ScreenWidth/3*[[change objectForKey:@"new"] integerValue];
//    }
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
//    NSLog(@"点击了＝%ld",tabBarController.selectedIndex);
//    [UIView animateWithDuration:0.2 animations:^{
//        self.lineLB.x = ScreenWidth/3*tabBarController.selectedIndex;
//    }];
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (tabBarController.selectedIndex==2 && [XYString isObjectNull:app.userKey]) {
//        LoginVC *MVC = [[LoginVC alloc] init];
//        MVC.Enter = 2;
//        [self presentViewController:MVC animated:YES completion:nil];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
