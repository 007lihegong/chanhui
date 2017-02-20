//
//  AppDelegate.m
//  chanhui
//
//  Created by 名侯 on 17/1/12.
//  Copyright © 2017年 侯彦名. All rights reserved.
//

#import "AppDelegate.h"
#import "Defines.h"
#import "RootTabBarController.h"
#import "IQKeyboardManager.h"
#import "UdeskManager.h"
#import "WUGesturesUnlockViewController.h"

@interface AppDelegate ()
{
    NSTimer *lockTime;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    RootTabBarController *root = [[RootTabBarController alloc] init];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    
    //定义键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = YES;
    manager.toolbarDoneBarButtonItemText = @"完成";
    manager.toolbarTintColor = GrayColor;
    
    //初始化 Udesk
    [UdeskManager initWithAppKey:@"c38aa814648e73352d90380610861911" appId:@"2ab1e980a3aaa423" domain:@"ybw100.udesk.cn"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"1");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"2");
    lockTime = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timeAction) userInfo:nil repeats:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"3");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"4");
    [lockTime invalidate];
    if (self.lockState==YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GesturesPassword" object:nil];
        self.lockState = NO;
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"5");
}

#pragma mark -- 退到后台 30s
- (void)timeAction {
    self.lockState = YES;
}

@end
