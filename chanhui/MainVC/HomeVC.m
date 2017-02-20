//
//  HomeVC.m
//  chanhui
//
//  Created by 名侯 on 17/1/12.
//  Copyright © 2017年 侯彦名. All rights reserved.
//

#import "HomeVC.h"
#import "MasonryTableViewCell.h"
#import "loginVC.h"
#import "WebVC.h"

@interface HomeVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *mainTV;
@property (nonatomic ,strong) NSMutableArray *dataList;

@end

static NSString *LXZTableViewCellIdentifier = @"cell";

@implementation HomeVC

- (UITableView *)mainTV {
    if (_mainTV==nil) {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        // 设置tableView自动高度
        _mainTV.rowHeight = UITableViewAutomaticDimension;
        [_mainTV registerClass:[MasonryTableViewCell class] forCellReuseIdentifier:LXZTableViewCellIdentifier];
        [self.view addSubview:_mainTV];
    }
    return _mainTV;
}

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    UIButton *sender1 = [UIButton new];
    sender1.backgroundColor = [UIColor blueColor];
    [sender1 setTitle:@"开始" forState:UIControlStateNormal];
    [sender1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sender1];
    
    UIButton *sender2 = [UIButton new];
    sender2.backgroundColor = [UIColor grayColor];
    [sender2 setTitle:@"结束" forState:UIControlStateNormal];
    [sender2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sender2];
    
    [self setYuan:sender1 size:5];
    [self setYuan:sender2 size:5];
    
    sender1.sd_layout
    .topSpaceToView(self.view,80)
    .leftSpaceToView(self.view,20)
    .widthIs((ScreenWidth-60)/2)
    .heightIs(40);
    
    sender2.sd_layout
    .topEqualToView(sender1)
    .leftSpaceToView(sender1,20)
    .rightSpaceToView(self.view,20)
    .heightRatioToView(sender1,1);
    
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"哈哈哈龙虾" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:btn];
    
    btn.sd_layout
    .topSpaceToView(self.view,150)
    .leftSpaceToView(self.view,20);
    //内部自适应
    [btn setupAutoSizeWithHorizontalPadding:10 buttonHeight:25];
    //视图圆角
    btn.sd_cornerRadius=@(5);
    
    UIButton *sender3 = [UIButton new];
    sender3.backgroundColor = [UIColor grayColor];
    [sender3 setTitle:@"动画" forState:UIControlStateNormal]; 
    [sender3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender3 addTarget:self action:@selector(sender3Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender3];
    
    sender3.sd_layout
    .topSpaceToView(sender2,30)
    .leftSpaceToView(sender1,20)
    .rightSpaceToView(self.view,20)
    .heightRatioToView(sender1,1);
    
    UIButton *sender4 = [UIButton new];
    sender4.backgroundColor = [UIColor grayColor];
    [sender4 setTitle:@"链接" forState:UIControlStateNormal];
    [sender4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender4 addTarget:self action:@selector(sender4Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender4];
    
    sender4.sd_layout
    .topSpaceToView(sender3,30)
    .leftSpaceToView(self.view,20)
    .rightSpaceToView(self.view,20)
    .heightRatioToView(sender1,1);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}
// 需要注意的是，这个代理方法和直接返回当前Cell高度的代理方法并不一样。
// 这个代理方法会将当前所有Cell的高度都预估出来，而不是只计算显示的Cell，所以这种方式对性能消耗还是很大的。
// 所以通过设置estimatedRowHeight属性的方式，和这种代理方法的方式，最后性能消耗都是一样的。
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
- (MasonryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MasonryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LXZTableViewCellIdentifier];
  
    return cell;
}

- (void)sender3Action {
    NSLog(@"点击了动画");
    
    loginVC *MVC = [[loginVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:MVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)sender4Action {
    
    WebVC *MVC = [[WebVC alloc] init];
    [self.navigationController pushViewController:MVC animated:YES];
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
