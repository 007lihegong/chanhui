//
//  ProductVC.m
//  chanhui
//
//  Created by 名侯 on 17/1/12.
//  Copyright © 2017年 侯彦名. All rights reserved.
//

#import "ProductVC.h"
#import "ZFWeiboButton.h"
#import "ZFIssueWeiboView.h"
#import "LTPickerView.h"
#import "IQKeyboardManager.h"

#import "LucPhotoHelper.h"
#import <AFNetworking.h>
#import "UdeskSDKManager.h"
#import "WaveView.h"

@interface ProductVC () <ZFIssueWeiboViewDelegate,LucPhotoHelperDelegate>

@property (strong, nonatomic) IBOutlet UITextField *passTF;
@property (strong, nonatomic) LucPhotoHelper *photoHelper;
@property (strong, nonatomic) IBOutlet UIButton *chatBT;

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRightImage:@"product_ release"];
    
    //[self setup];
    
    //选择相册
    if (!_photoHelper) {
        //编辑头像
        _photoHelper = [[LucPhotoHelper alloc]init];
        _photoHelper.target = self;
        _photoHelper.delegate = self;
    }
}

#pragma mark -- 波浪的点击事件
- (IBAction)wavesAction {
    [self setWaves];
}

- (void)setWaves {
    
    [[self.view viewWithTag:111] removeFromSuperview];
    [[self.view viewWithTag:112] removeFromSuperview];
    
    CGFloat sd = arc4random_uniform(5);
    CGFloat fd1 = 15+arc4random_uniform(5);
    CGFloat fd2 = 15+arc4random_uniform(15);
    
    NSLog(@"速度＝%.2f,幅度1＝%.2f,幅度2=%.2f",sd,fd1,fd2);
    
    WaveView *wave1 = [[WaveView alloc]initWithFrame:CGRectMake(0, (ScreenHeight-113) * 0.5, ScreenWidth, (ScreenHeight-113) * 0.5)];
    [self.view addSubview:wave1];
    wave1.tag = 111;
    //波浪的速度
    wave1.waveSpeed = sd;//3
    //波浪的幅度
    wave1.waveAmplitude = fd1;//20
    [wave1 wave];
    
    WaveView *wave2 = [[WaveView alloc]initWithFrame:CGRectMake(0, (ScreenHeight-113) * 0.5, ScreenWidth, (ScreenHeight-113) * 0.5)];
    [self.view addSubview:wave2];
    wave2.tag = 112;
    wave2.waveSpeed = sd;//5
    wave2.waveAmplitude = fd2;//30
    [wave2 wave];
}
#pragma mark -- UIImagePickerControllerDelegate (拍照)
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"方法1=%@",info);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self sendImageRequest:portraitImg];
    
    //    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
}
#pragma mark -- 相册代理
- (void)LucPhotoHelperGetPhotoSuccess:(UIImage *)image {
    [self sendImageRequest:image];
}
#pragma mark -- 上传图片的接口
- (void)sendImageRequest:(UIImage *)image {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"qFH5DEWMVNscaiBqa6a4vwQVKaFIxk9Z" forKey:@"api_key"];
    [param setValue:@"mKx8ILx0kf9l03uF6BDOjArdPUggEdlW" forKey:@"api_secret"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"pp%@.png", str];
    
    AFHTTPSessionManager *mar = [AFHTTPSessionManager manager];
    //这句没加 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    mar.responseSerializer = [AFHTTPResponseSerializer serializer];
    mar.requestSerializer = [AFHTTPRequestSerializer serializer];
    mar.requestSerializer.timeoutInterval = 30.f;
    
    [mar POST:@"https://api-cn.faceplusplus.com/cardpp/v1/ocridcard" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:@"image_file" fileName:fileName mimeType:@"image/png"]; //可能image/png
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"进度:%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"返回结果＝%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"返回失败＝%ld",error.code);
    }];
}
- (void)setup {
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = NO;
    manager.enableAutoToolbar = NO;
    
    LTPickerView *pickV = [LTPickerView new];
    pickV.dataSource = @[@"关羽",@"张飞",@"赵云"];
    [pickV show];
    [pickV setBlock:^(id obj, NSString *str, int num) {
        _passTF.text = str;
        [_passTF endEditing:YES];
    }];
    self.passTF.inputView = pickV;
}
#pragma mark -- 右边发布事件
- (void)rightNavAction {
    
    //ZFIssueWeiboView *view = [ZFIssueWeiboView initIssueWeiboView];
    //view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //view.delegate = self;
    //[appdelegate.window addSubview:view];
    [_photoHelper editPortraitInView:self.view];
}
#pragma mark -- 发布按钮的代理
- (void)animationHasFinishedWithButton:(ZFWeiboButton *)button {
    
}

#pragma mark -- 聊天按钮
- (IBAction)chatAction {
    
    
    NSDictionary *parameters = @{
                                 @"user": @{
                                         @"nick_name": @"老司机",
                                         @"cellphone":@"15281047298",
                                         @"email":@"806505978@qq.com",
                                         @"description":@"用户描述",
                                         @"sdk_token":@"215"
                                         }
                                 };
    [UdeskManager createCustomerWithCustomerInfo:parameters];
    
    //此处只是示例，更多UI参数请参看 UdeskSDKStyle.h
    UdeskSDKStyle *sdkStyle = [UdeskSDKStyle customStyle];
    sdkStyle.navigationColor = mainHong;
    sdkStyle.titleColor = [UIColor whiteColor];
    
    //UdeskSDKManager *chat = [[UdeskSDKManager alloc] initWithSDKStyle:sdkStyle];
    //[chat pushUdeskViewControllerWithType:UdeskIM viewController:self completion:nil];
    
    //使用push
    UdeskSDKManager *chat = [[UdeskSDKManager alloc] initWithSDKStyle:sdkStyle];
    //UdeskRobot 机器人
    [chat setTransferToAgentMenu:YES];
    [chat pushUdeskViewControllerWithType:UdeskRobot viewController:self completion:nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
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
