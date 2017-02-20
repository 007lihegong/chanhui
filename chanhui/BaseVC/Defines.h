//
//  Defines.h
//  框架一
//
//  Created by Apple on 15/12/16.
//
//

//--------------------------------------   框架初定义   --------------------------------------------------------------//

#ifndef Defines_h
#define Defines_h
#import <Masonry.h>
//http://server.ybw100.com/
#define IP @"http://server.ybw100.com"
#define IMAGES @"http://qw.coolmoban.com/Public/images/"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SDKLV [[[UIDevice currentDevice] systemVersion] floatValue]
//ARC BLOCK
#define WEAKSELF __weak __typeof(&*self)weakSelf = self;
#define STRONGSELF __strong __typeof(weakSelf)strongSelf = weakSelf;

#define color(r,g,b,p) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:p]
//十六进制色值+透明度
#define colorValue(rgbValue,transparentValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:transparentValue]

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define Screen_Bounds [UIScreen mainScreen].bounds
#define Multiple [[UIScreen mainScreen] bounds].size.width/375

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
//get the right bottom origin's x,y of a view
#define kVIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define kVIEW_BY(view) (view.frame.origin.y + view.frame.size.height)
#define kIMG(iname) [UIImage imageNamed:iname]

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif
//是否为空
#define isNull(a)  ( (a==nil) || ((NSNull*)a==[NSNull null]) )
#define isNotNull(a)  (!isNull(a))
#define avoidNullStr(a) isNull(a) ? @"" : a

#define GrayColor color(125, 129, 133, 1) //tabar 字的颜色（默认）
#define FatherColor color(53, 172, 255, 1) //tabar 字的颜色（选中）
#define BorderColor colorValue(0xC0C0C0,1) //线的颜色 （系统线 0xC0C0C0）
#define sublineColor colorValue(0xe5e5e5,1) //线的颜色
#define BackGroundColor colorValue(0xecedf1,1) //父视图背景色
#define TabberColor color(75,190,170,1) //tabar 背景色

#define FooterImage @"footerimage" //tabar 图片
#define FooterViewControl @"viewcontrol" //tabar 控制器
#define FooterName @"footername" //tabar 名字

//--------------------------------------   项目中定义   --------------------------------------------------------------//

//存储数据
#define userToken @"token"
#define userTele @"Tele"

//#define mainHuang  colorValue(0xff6430,1)//主题色 黄色
//#define mainHuang2  colorValue(0xfb8d6b,1)//主题色 淡色
//#define textLan  colorValue(0x0066fb,1)//标题色 蓝色

#define mainLan colorValue(0x188afa,1) //主题 蓝
#define mainHong colorValue(0xE3170D,1) //主题红

#define textTitle  colorValue(0x333333,1)//标题色 黑色
#define textSubtitle  colorValue(0x666666,1)//副标题色 灰色

#define font_1 @"Heiti SC" //字体1
#define Custele @"028-65359999" //tabar 名字

#endif /* Defines_h */
