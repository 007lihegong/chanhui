//
//  registeredVC.m
//  chanhui
//
//  Created by 名侯 on 17/2/9.
//  Copyright © 2017年 侯彦名. All rights reserved.
//

#import "registeredVC.h"

#import "UIViewController+XWTransition.h"

@interface registeredVC ()

@end

@implementation registeredVC

- (void)viewDidLoad {
    self.title = @"注册";
    [super viewDidLoad];
    
    [self setup];
    
    //注册手势
    __weak typeof(self)weakSelf = self;
    [self xw_registerBackInteractiveTransitionWithDirection:XWInteractiveTransitionGestureDirectionRight transitonBlock:^(CGPoint startPoint){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } edgeSpacing:0];
    
    UIView *navBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navBack.backgroundColor = mainHong;
    [self.view addSubview:navBack];
}

- (void)setup {
    
    UIButton *sender1 = [UIButton new];
    sender1.backgroundColor = [UIColor grayColor];
    [sender1 setTitle:@"确认" forState:UIControlStateNormal];
    [sender1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [sender1 addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender1];
    
    sender1.sd_layout
    .topSpaceToView(self.view,200)
    .leftSpaceToView(self.view,20)
    .widthIs(ScreenWidth-40)
    .heightIs(40);
    
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
