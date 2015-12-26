//
//  CommonDefine.h
//  BankFinancing
//
//  Created by Howard Dong on 12-10-19.
//  Copyright (c) 2012年 gw. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
//#import "CMBaseFramework.h"
//#import "DLDataManagement.h"
//#import "DLUserManagement.h"
//#import "DLCommonDefine.h"
//#import "CommonDrawFunc.h"



#ifndef __COMMONDEFINE__
#define __COMMONDEFINE__

#define kFloatCompareZero		0.0000001
#define kScreenH  ([[UIScreen mainScreen]bounds].size.height)
#define kScreenW  ([[UIScreen mainScreen]bounds].size.width)

#define nextX(rect, offset) (rect.origin.x + rect.size.width + offset)          // 计算下一个x
#define nextY(rect, offset) (rect.origin.y + rect.size.height + offset)         // 计算下一个y

//#define kTerminalId             @"iphone"        // 终端标识
#define kDeviceIDKey            @"DeviceID"

#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//彩票用户登录成功，上传device token，推送登录
//需要在每回切换账号，或者自动登录后发出此通知，确保切换账号后可以收到用户关注的团队推送
#define kObserveBindDeviceToken             @"kObserveBindDeviceToken"
#define HDMedicalAppDelegate [UIApplication sharedApplication].delegate

#define kSysStatusBarHeight		MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height)		// 系统状态栏高度
#define kSysNavBarHeight        44      //导航栏高度
#define kSysHorzNavBarHeight	32		// 横屏系统导航栏高度
#define kSysNavBarHeightAboveIOS7 66    //导航栏高度
#define KCommonDefineTabBarHeight 49    // 自定义下面tab高度



// RGB颜色方法
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kCollapseViewBorderColor                [UIColor colorWithRed:255/255.0f green:239/255.0f blue:216/255.0f alpha:1.0]

#ifndef _ENUM_GAME_TYPE_ID_
#define _ENUM_GAME_TYPE_ID_
typedef enum _GameTypeId
{
    // 竞彩足球
    GameTypeJcNone  = 120,  // 合买
    
} GameTypeId;


#endif

#define kClinetType 54      // 客户端平台     53:android;    54:ios;    55:wp

//#define IntegerForKey(key) [NSString stringWithFormat:@"%d",(key)]
#define IntegerForKey(key) [NSNumber numberWithInteger:(key)]
#define KeyForSection(section) [NSString stringWithFormat:@"%d",(section)]

#define kContentHeight self.view.frame.size.height-kSysStatusBarHeight-kSysNavBarHeight  //有导航栏的ViewController中内容高度  通过动态获取view的高度，可以适配不同尺寸iphone设备
#define kContentHeightNoNav self.view.frame.size.height-kSysStatusBarHeight  //无导航栏的ViewController中内容高度  通过动态获取view的高度，可以适配不同尺寸iphone设备

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    #define IOS_VERSION_7_OR_ABOVE ((floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#else
    #define IOS_VERSION_7_OR_ABOVE NO
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_5_1
    #define IOS_VERSION_6_OR_ABOVE ((floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) && [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#else
    #define IOS_VERSION_6_OR_ABOVE NO
#endif

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#endif // __COMMONDEFINE__


#pragma mark - 恒大销售


#define KHDSBaseURL           @"http://beta.service.wehop.cn/user-platform-web-1.0.0/rest/"
#define KHDLoginURL           @"http://beta.service.wehop.cn/sales-platform-web-1.0-SNAPSHOT/rest/login"
#define KHDCheckURL           @"http://beta.service.wehop.cn/sales-platform-web-1.0-SNAPSHOT/rest/validateToken"



#define KHDSMainURL           @"http://cdn.oss.wehop-resources-beta.wehop.cn/sales/app/sites/v-1/index.html"
#define KHDSProcessURL        @"http://cdn.oss.wehop-resources-beta.wehop.cn/sales/app/sites/v-1/task.html"

#define KHDMedicalADVImg                @"KHDMedicalADVImg"
#define KHDSaleAlreadLogin              @"KHDSaleAlreadLogin"
#define KHDSaleAlreadLogout             @"KHDSaleAlreadLogOut"