//
//  BaseVC.m
//  kuangjia
//
//  Created by 名侯 on 16/8/15.
//  Copyright © 2016年 侯彦名. All rights reserved.
//

#import "BaseVC.h"
#import <AFNetworking.h>
#import "WUGesturesUnlockViewController.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BackGroundColor];
    appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //自定义标题
    [self configureTitleView];
    
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //注册通知(手势密码)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GesturesPassword) name:@"GesturesPassword" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GesturesPassword" object:nil];
}
//自定义导航栏
- (UIView *)setNav:(NSString *)string add:(UIView *)view {
    
    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    nav.backgroundColor = [UIColor whiteColor];
    [view addSubview:nav];
    
    UIButton *sender = [UIButton new];
    [sender setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [sender setTitleColor:textTitle forState:UIControlStateNormal];
    [sender setTitle:string forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    
    [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [sender setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    sender.frame = CGRectMake(18, 30, 80, 14);
    [sender sizeToFit];
    [sender addTarget:self action:@selector(backNavAction) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:sender];
    
    return nav;
}
//自定义标题
- (void)configureTitleView
{
    UILabel *headlinelabel = [UILabel new];
    headlinelabel.font = [UIFont fontWithName:@"Avenir-Light" size:20];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor = [UIColor whiteColor];
    
    headlinelabel.text = self.title;
    [headlinelabel sizeToFit];
    
    [self.navigationItem setTitleView:headlinelabel];
}
//自定义导航栏右边按钮--文字
- (void)configureRight:(NSString *)string {
    
    UILabel *headlinelabel = [UILabel new];
    headlinelabel.font = [UIFont fontWithName:@"Avenir-Light" size:14];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor = [UIColor whiteColor];
    headlinelabel.userInteractionEnabled = YES;
    headlinelabel.text = string;
    [headlinelabel sizeToFit];
    //设置手势
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightNavAction)];
    [headlinelabel addGestureRecognizer:rightTap];
    UIBarButtonItem *rightbar=[[UIBarButtonItem alloc] initWithCustomView:headlinelabel];
    self.navigationItem.rightBarButtonItem = rightbar;
}
//自定义返回按钮
- (void)configureLeft:(NSString *)string {
    
    UIButton *sender = [UIButton new];
    [sender setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [sender setTitleColor:colorValue(0x333333, 1) forState:UIControlStateNormal];
    [sender setTitle:string forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    
    [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [sender setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    
    [sender sizeToFit];
    [sender addTarget:self action:@selector(backNavAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftbar=[[UIBarButtonItem alloc] initWithCustomView:sender];
    self.navigationItem.leftBarButtonItem = leftbar;
}

//自定义导航栏右边按钮--图片
- (void)configureRightImage:(NSString *)imgName {
    
    UIButton *NavRightBT = [UIButton new];
    [NavRightBT setImage:kIMG(imgName) forState:UIControlStateNormal];
    [NavRightBT addTarget:self action:@selector(rightNavAction) forControlEvents:UIControlEventTouchUpInside];
    [NavRightBT sizeToFit];
    
    UIBarButtonItem *rightbar=[[UIBarButtonItem alloc] initWithCustomView:NavRightBT];
    self.navigationItem.rightBarButtonItem = rightbar;
}

- (void)rightNavAction {
    NSLog(@"点击了导航栏右边按钮");
}
- (void)backNavAction {
    [self.navigationController popViewControllerAnimated:YES];
}
//设置边框
-(void)setBorder:(UIView *)view size:(float)size{
    CGFloat width = 1/[UIScreen mainScreen].scale;
    view.layer.borderColor=BorderColor.CGColor;
    view.layer.borderWidth=size*width;
}
//设置边框+颜色
-(void)setBorder:(UIView *)view size:(float)size withColor:(UIColor *)color{
    CGFloat width = 1/[UIScreen mainScreen].scale;
    view.layer.borderColor=color.CGColor;
    view.layer.borderWidth=width*size;
}
//设置成圆形
-(void)setYuan:(UIView *)view size:(double)size{
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=size;
}
//阴影
- (void)setshadow:(UIView *)view {
    //    CALayer *layer = [view layer];
    //    layer.borderColor = [[UIColor whiteColor] CGColor];
    
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowOpacity = 0.3;
    view.layer.shadowRadius = 1;
}
//阴影自定义
- (void)setshadow:(UIView *)view scope:(CGFloat)width transparent:(CGFloat)alpha direction:(CGSize)size {
    
    view.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    view.layer.shadowOffset = CGSizeMake(size.width, size.height);//阴影方向
    view.layer.shadowOpacity = alpha;//阴影透明度
    view.layer.shadowRadius = width;//阴影范围
}
//生产1像素的线
- (void)PixeOrigin:(CGPoint)origin length:(CGFloat)length isVertical:(BOOL)isVertical color:(UIColor *)color add:(UIView *)supview {
    CGFloat width = 1/[UIScreen mainScreen].scale;
    CGFloat offset = ((1-[UIScreen mainScreen].scale)/2);
    
    UIView *view;
    if (isVertical) {   // 垂直的线
        view = [[UIView alloc] initWithFrame:CGRectMake(ceil(origin.x) + offset, origin.y, width, length)];
    }
    else {  // 水平的线
        view = [[UIView alloc] initWithFrame:CGRectMake(origin.x, ceil(origin.y)+(1-width), length, width)];
    }
    view.backgroundColor = color;
    [supview addSubview:view];
}
//默认水平线
- (void)PixeH:(CGPoint)origin lenght:(CGFloat)length add:(UIView *)supview {
    
    CGFloat width = 1/[UIScreen mainScreen].scale;
    CGFloat offset;
    if (origin.y==0) {
        offset = 0;
    }else {
        offset = 1-width;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(origin.x, ceil(origin.y)+offset, length, width)];
    view.backgroundColor = BorderColor;
    [supview addSubview:view];
}
//默认垂直线
- (void)PixeV:(CGPoint)origin lenght:(CGFloat)length add:(UIView *)supview {
    CGFloat width = 1/[UIScreen mainScreen].scale;
    CGFloat offset = ((1-[UIScreen mainScreen].scale)/2);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ceil(origin.x) + offset, origin.y, width, length)];
    view.backgroundColor = BorderColor;
    [supview addSubview:view];
}
//收键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
//存值
- (void)setUserifon:(id)value andKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

#pragma mark -- AFN网络框架
- (void)post:(NSString *)URLString parameters:(NSMutableDictionary *)parameters show:(BOOL)loading success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *path = [NSString stringWithFormat:@"%@%@",IP,URLString];
    [parameters setValue:@"ios" forKey:@"terminalType"];
    [parameters setValue:@"api" forKey:@"qType"];
    NSLog(@"url=%@",path);
    NSLog(@"参数=%@",parameters);
    
    AFHTTPSessionManager *mar = [AFHTTPSessionManager manager];
    mar.responseSerializer = [AFHTTPResponseSerializer serializer];
    mar.requestSerializer.timeoutInterval = 30.f;
    
    [mar POST:path parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //json字符串
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"请求成功＝%@",dataStr);
        if (success) {
            if (![XYString isObjectNull:dic]) {
                if ([dic[@"code"] intValue]==1006||[dic[@"code"] intValue]==1005) {
                  
                }else {
                    success(dic);
                }
            }else {
                if (loading==YES) {
                    [LCProgressHUD showMessage:@"服务器异常，稍后重试"];
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败＝%@",error);
//        if (loading==YES) {
//            if (appdelegate.networkStatus) {
//                [LCProgressHUD showMessage:@"服务器异常，稍后重试"];
//            }else {
//                [LCProgressHUD showMessage:@"网络异常，稍后重试"];
//            }
//        }else {
//            [LCProgressHUD hide];
//        }
//        if (failure) {
//            failure(error);
//        }
    }];
}

//---------------------------------------------------

- (void)postImg:(NSString *)URLString parameters:(id)parameters sendImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString *path = [NSString stringWithFormat:@"%@%@",IP,URLString];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"pp%@.png", str];
    
    NSLog(@"文件名＝%@",fileName);
    NSLog(@"url=%@",path);
    NSLog(@"param=%@",parameters);
    
    AFHTTPSessionManager *mar = [AFHTTPSessionManager manager];
    //这句没加 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    mar.responseSerializer = [AFHTTPResponseSerializer serializer];
    mar.requestSerializer = [AFHTTPRequestSerializer serializer];
    mar.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    mar.requestSerializer.timeoutInterval = 30.f;
    
    [mar POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //        NSData *data = UIImagePNGRepresentation(image);
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"]; //可能image/png
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度:%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"请求成功＝%@",dic);
        if (success) {
            if (![XYString isObjectNull:dic]) {
                success(dic);
            }else {
                [LCProgressHUD showMessage:@"服务器异常，稍后重试"];
                success(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败＝%@",error);
//        if (appdelegate.networkStatus) {
//            [LCProgressHUD showMessage:@"服务器异常，稍后重试"];
//        }else {
//            [LCProgressHUD showMessage:@"网络异常，稍后重试"];
//        }
//        if (failure) {
//            failure(error);
//        }
    }];
}

- (UIButton *)setMainButton:(NSString *)string add:(UIView *)view setY:(CGFloat)btY {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, btY, ScreenWidth-40, 40)];
//    button.backgroundColor = mainHuang;
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setYuan:button size:20];
    [button addTarget:self action:@selector(mainButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    return button;
}
- (void)mainButtonAction {
    
}
- (UILabel *)setLable:(CGRect)rect setText:(NSString *)text setTextColor:(UIColor *)color setFont:(UIFont *)font addView:(UIView *)view {
    UILabel *titleLB = [[UILabel alloc] initWithFrame:rect];
    titleLB.text = text;
    titleLB.textColor = color;
    titleLB.font = font;
    [view addSubview:titleLB];
    return titleLB;
}

- (void)GesturesPassword {
    if ([WUGesturesUnlockViewController gesturesPassword].length > 0) {
        WUGesturesUnlockViewController *vc = [[WUGesturesUnlockViewController alloc] initWithUnlockType:WUUnlockTypeValidatePwd];
        [self presentViewController:vc animated:YES completion:nil];
    }
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
