//
//  MyVC.m
//  chanhui
//
//  Created by 名侯 on 17/1/12.
//  Copyright © 2017年 侯彦名. All rights reserved.
//

#import "MyVC.h"
#import "fontVC.h"
#import "WUGesturesUnlockViewController.h"

@interface MyVC () <UITableViewDelegate,UITableViewDataSource>{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程度

}

@property (nonatomic, strong) UIImageView        *transformView;//发生变换的试图
@property (nonatomic, strong) UIView        *backGroundView;//发生变换试图的父试图
@property (nonatomic, strong) NSArray       *dataSourceAry;//数据源数组

@end

@implementation MyVC

-(NSArray *)dataSourceAry{
    if (!_dataSourceAry) {
        _dataSourceAry = @[@"缩放变换",@"平移变换",@"翻转变换",@"旋转变换",@"剪切变换",@"手势密码"];
    }
    return _dataSourceAry;
}
-(UIImageView *)transformView{
    if (!_transformView) {
        _transformView =[[UIImageView alloc]init];
        _transformView.tag = 12;
        
        [_transformView setMultipleTouchEnabled:YES];
        [_transformView setUserInteractionEnabled:YES];
        [_transformView setImage:[UIImage imageNamed:@"1.jpg"]];
        
    }
    return _transformView;
}
-(UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backGroundView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5f];
        _backGroundView.tag = 11;
    }
    return _backGroundView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"来了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRight:@"字体"];
    
    [self setup];
}

- (void)setup {
    
    UITableView *mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    mainTV.delegate = self;
    mainTV.dataSource = self;
    [self.view addSubview:mainTV];
}
#pragma mark - tableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceAry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transformCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"transformCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSourceAry[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==5) {
        WUGesturesUnlockViewController *vc = [[WUGesturesUnlockViewController alloc] initWithUnlockType:WUUnlockTypeCreatePwd];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:vc animated:YES completion:nil];
        });
    }else {
        [self poppingViewWithTransform:self.dataSourceAry[indexPath.row]];
    }
    
}

-(void)poppingViewWithTransform:(NSString *)transformStr{
    
    
    [self.view addSubview:self.backGroundView];
    
    self.transformView.image = [UIImage imageNamed:@"my_lufei.jpeg"];
    self.transformView.frame = CGRectMake(ScreenWidth/2-100, 100, 200, 200);
    oldFrame = _transformView.bounds;
    largeFrame = CGRectMake(0 - ScreenWidth, 0 - ScreenHeight, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
    [self addGestureRecognizerToView:_transformView];
    self.transformView.transform = CGAffineTransformIdentity;

    if ([transformStr isEqualToString:@"缩放变换"]) {
        //很简单的变换效果，200，为Y轴从下往上平移，相反-200 是从上往下平移
        self.transformView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        [UIView animateWithDuration:0.5 animations:^{
            self.transformView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
        
    }else if([transformStr isEqualToString:@"平移变换"]){
        //很简单的变换效果，200，为Y轴从下往上平移，相反-200 是从上往下平移，X轴变换同理
        self.transformView.transform = CGAffineTransformMakeTranslation(0, -200);
        [UIView animateWithDuration:0.5 animations:^{
            self.transformView.transform = CGAffineTransformMakeTranslation(1.0,1.0);
        }];
    }else if([transformStr isEqualToString:@"翻转变换"]){
        //下面注释的代码，最后Z轴改成一个数字，例12，可以实现旋转变换
        //self.transformView.layer.transform = CATransform3DMakeRotation(12, 1, 1, 0);
        _transformView.image = [UIImage imageNamed:@"my_shanzhi.jpeg"];
        self.transformView.layer.transform =  [self firstStep];
        [UIView animateWithDuration:0.5 animations:^{
            self.transformView.layer.transform = CATransform3DMakeRotation(0, 1, 0, 0);
        }];
    }else if([transformStr isEqualToString:@"旋转变换"]){
        _transformView.image = [UIImage imageNamed:@"my_suolong.jpeg"];
        //具体效果可以更改 M_PI_4 角度来实现
        self.transformView.transform = CGAffineTransformMake(( cos(M_PI_4) ), ( sin(M_PI_4) ), -( sin(M_PI_4) ), (cos(M_PI_4) ), 0, 0);
        [UIView animateWithDuration:0.5 animations:^{
            self.transformView.transform = CGAffineTransformMake(( cos(M_PI) ), ( sin(M_PI) ), -( sin(M_PI) ), (cos(M_PI) ), 0, 0);
        }];
    }else if([transformStr isEqualToString:@"剪切变换"]){
        //使用仿射基础方法CGAffineTransformMake,设置x和y都为0.5的斜切
        //可以试着把第一个1换成0.5，看看效果
        //可以试着把第二个1换成0.5，看看效果
        self.transformView.transform =  CGAffineTransformMake(1,0.5,0.5,1,0,0);
        [UIView animateWithDuration:0.5 animations:^{
            self.transformView.transform = CGAffineTransformMake(1,0,0,1,0,0);
        }];
    }
    
    
    self.transformView.layer.cornerRadius = 7;
    self.transformView.layer.masksToBounds = YES;
    [self.backGroundView addSubview:self.transformView];
    
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.backGroundView addGestureRecognizer:singleTapGestureRecognizer];
    
    UITapGestureRecognizer *BGsingleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [BGsingleTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.transformView addGestureRecognizer:BGsingleTapGestureRecognizer];
}

-(CATransform3D)firstStep{
    
    //让transform1为单位矩阵
    CATransform3D transform1 = CATransform3DIdentity;
    //z轴纵深的3D效果和CATransform3DRotate配合使用才能看出效果
    //m34很重要
    transform1.m34 = 1.0/-100;
    //x和y都缩小为原来的0.9，z不变
    transform1 = CATransform3DScale(transform1, 0.9, 0.9, 1);
    //绕x轴向内旋转30度
    transform1 = CATransform3DRotate(transform1,15.0f * M_PI/180.0f, 1, 0, 0);
    return transform1;
}

//点击手势
-(void)singleTap:(UITapGestureRecognizer *)gesture{
    
    if (gesture.view.tag == 11) {
        
        NSLog(@"点击的父试图,移除试图");
        [self.backGroundView removeFromSuperview];
        [self.transformView removeFromSuperview];
        self.transformView = nil;
    }else{
        
        NSLog(@"点击的子试图,不移除试图");
        return;
    }
}

- (void)rightNavAction {
    
    fontVC *MVC = [[fontVC alloc] init];
    [self.navigationController pushViewController:MVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
   // UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    //[view addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}


@end
