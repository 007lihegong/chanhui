//
//  loginVC.m
//  chanhui
//
//  Created by 名侯 on 17/2/9.
//  Copyright © 2017年 侯彦名. All rights reserved.
//

#import "loginVC.h"
#import "XWCoolAnimator.h"
#import "registeredVC.h"

#import "UIViewController+XWTransition.h"
#import "UINavigationController+XWTransition.h"

@interface loginVC ()

@end

@implementation loginVC

- (void)viewDidLoad {
    self.title = @"登录";
    [super viewDidLoad];
    //self.edgesForExtendedLayout=UIRectEdgeBottom;//下移64
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.barTintColor = mainHong;
    self.view.backgroundColor = [UIColor greenColor];
    [self setup];
    
    //注册手势
    __weak typeof(self)weakSelf = self;
    [self xw_registerToInteractiveTransitionWithDirection:XWInteractiveTransitionGestureDirectionLeft transitonBlock:^(CGPoint startPoint){
        [weakSelf senderAction];
    } edgeSpacing:0];
    
    self.navigationController.navigationBar.barTintColor = mainHong;
}


- (void)setup {
    
    UIView *navBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navBack.backgroundColor = mainHong;
    [self.view addSubview:navBack];
    
    UIButton *sender1 = [UIButton new];
    sender1.backgroundColor = [UIColor blueColor];
    [sender1 setTitle:@"注册" forState:UIControlStateNormal];
    [sender1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender1 addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender1];
    
    sender1.sd_layout
    .topSpaceToView(self.view,200)
    .leftSpaceToView(self.view,20)
    .widthIs(ScreenWidth-40)
    .heightIs(40);
    
}

- (void)senderAction {
    
    XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePageMiddleFlipFromRight];
    animator.toDuration = 1.0f;
    animator.backDuration = 1.0f;
    registeredVC *toVC = [registeredVC new];
    [self.navigationController xw_pushViewController:toVC withAnimator:animator];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
