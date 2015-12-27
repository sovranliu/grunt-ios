//
//  HDSMainViewController.m
//  HDMedical
//
//  Created by David on 15-8-10.
//  Copyright (c) 2015年 HD. All rights reserved.
//

#import "HDSMainViewController.h"
#import "HDSLoginViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "NSString+Utils.h"
#import "CCLocationManager.h"
#import "JSONFormatFunc.h"

@interface HDSMainViewController ()

@end

@implementation HDSMainViewController
@synthesize javascriptBridge = _bridge;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title      = @"首页";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"home_footbar_icon_shouye" selIconImgName:@"home_footbar_icon_shouye_pressed"];
        
    }
    return self;
}

- (void)initExtendedData
{
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KHDMedicalADVImg object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KHDSaleAlreadLogin object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KHDSaleAlreadLogout object:nil];
}


- (void)loadUIData
{
    self.navigationController.navigationBar.hidden = YES;
    
    self.mainwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH- 49)];
    self.mainwebView.delegate = self;
    self.mainwebView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:self.mainwebView];
    
    if (![DataEngine sharedDataEngine].isLogin)
    {
        HDSLoginViewController * loginVC = [[HDSLoginViewController alloc] init];
        
        UINavigationController * rootNavigationVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:rootNavigationVC animated:YES completion:nil];
        
    }else
    {
        [self loadRequestURL];
    }
    
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.mainwebView handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");
    }];


    
    [_bridge registerHandler:@"wifi" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"wifiObjcCallback called: %@", data);
        responseCallback(@"Response from wifiObjcCallback");
    }];
    
    [_bridge registerHandler:@"gps" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"gpsObjcCallback called: %@", data);
        
        //NSString * latuadeStr = [self gpsAttitude];;
        
        
        [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            
            NSLog(@"latitude=%f, longitude%f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
            NSString * latitudeStr= [NSString stringWithFormat:@"{latitude:%f,longitude:%f}",locationCorrrdinate.latitude,locationCorrrdinate.longitude];
            responseCallback(latitudeStr);
        }];
        
        
        
        
    }];
    
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadRequestURL)
                                                 name:KHDSaleAlreadLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showLoginVC)
                                                 name:KHDSaleAlreadLogout object:nil];
    
    [self checkToken];
    
     // check
    
}

-(void)loadRequestURL
{
    NSString * tokenStr = [NSString stringWithFormat:@"%@?token=%@",KHDSMainURL,[DataEngine sharedDataEngine].deviceToken];
    NSURL* url = [NSURL URLWithString:tokenStr];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.mainwebView loadRequest:request];//加载
}

- (void)checkToken
{
    //总参数封装
    NSMutableDictionary * totalParamDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    [totalParamDic setObject:[DataEngine sharedDataEngine].userName forKey:@"username"];
    [totalParamDic setObject:[DataEngine sharedDataEngine].deviceToken forKey:@"token"];
    
    NSMutableString * baseUrl = [NSMutableString stringWithString:KHDCheckURL];
    // 发送数据
    [[DataEngine sharedDataEngine] reqAsyncHttpPost:self urlStr:baseUrl userInfo:totalParamDic withReqTag:1];
}

- (void)showLoginVC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更UI
        HDSLoginViewController * loginVC = [[HDSLoginViewController alloc] init];
        
        UINavigationController * rootNavigationVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:rootNavigationVC animated:YES completion:nil];

    });
    
}

- (NSString *)gpsAttitude
{
     __block NSString * latitudeStr = @"";
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        
        NSLog(@"latitude=%f, longitude%f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
        latitudeStr= [NSString stringWithFormat:@"{latitude:%f,longitude:%f}",locationCorrrdinate.latitude,locationCorrrdinate.longitude];
    }];
    NSLog(@"latitudeStr = %@",latitudeStr);
    return latitudeStr;
}

#pragma mark ---UIWebView delegate
-(void)webViewDidStartLoad:(UIWebView*)webView //当网页视图已经开始加载一个请求后，得到通知。
{
    
}
-(void)webViewDidFinishLoad:(UIWebView*)webView ;//当网页视图结束加载一个请求之后，得到通知。
{
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error;//当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型。
{
    
}

- (void)reflashTargetUI:(UIViewController *)vc responseData:(id)responseData withTag:(int)tag
{
    NSLog(@"responseData = %@",responseData);
    if (vc == self&& [responseData isKindOfClass:[NSDictionary class]] && tag == 1)//
    {
        int code = [[responseData objectForKey:@"code"] intValue];
        NSString * msg =[JSONFormatFunc strValueForKey:@"msg" ofDict:responseData];
        NSLog(@"code = %d,msg =%@",code,msg);
        if (code == 1) // check成功
        {
            
        }else
        {
            [self showLoginVC];
 
        }
    }
}

- (void)parseJsonDataInUI:(UIViewController *)vc jsonData:(id)jsonData withTag:(int)tag
{
    
}

- (void)httpResponseError:(UIViewController *)vc errorInfo:(NSError *)error withTag:(int)tag
{
    
}

- (void)didSelectedTabBarItem
{
    NSLog(@"didSelectedTabBarItem =%@",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
