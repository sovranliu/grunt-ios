//
//  HDSProcessViewController.m
//  HDMedical
//
//  Created by David on 15-8-10.
//  Copyright (c) 2015年 HD. All rights reserved.
//

#import "HDSProcessViewController.h"

@interface HDSProcessViewController ()


@end

@implementation HDSProcessViewController
@synthesize javascriptBridge = _bridge;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title      = @"任务";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"home_footbar_icon_task" selIconImgName:@"home_footbar_icon_task_pressed"];
        //[self createTabBarItem:self.title iconImgName:nil selIconImgName:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KHDSaleAlreadLogin object:nil];
}

- (void)initExtendedData
{
    
}

- (void)loadUIData
{
//    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [scanButton setTitle:@"扫描" forState:UIControlStateNormal];
//    scanButton.frame = CGRectMake(100, 100, 120, 40);
//    [scanButton addTarget:self action:@selector(setupCamera) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:scanButton];
//    
//    UIButton * gpsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [gpsButton setTitle:@"gps" forState:UIControlStateNormal];
//    gpsButton.frame = CGRectMake(100, 150, 120, 40);
//    [gpsButton addTarget:self action:@selector(gpsAttitude) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:gpsButton];
    self.navigationController.navigationBar.hidden = YES;
    
    self.mainwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH- 49)];
    self.mainwebView.delegate = self;
    if ([DataEngine sharedDataEngine].isLogin) {
        [self loadRequestURL];
    }
    [self.view addSubview:self.mainwebView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadRequestURL)
                                                 name:KHDSaleAlreadLogin object:nil];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.mainwebView handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"ObjC received message from JS: %@", data);
//        responseCallback(@"Response for message from ObjC");
    }];
    
    
    
    [_bridge registerHandler:@"capture" handler:^(id data, WVJBResponseCallback responseCallback) {
        //NSLog(@"wifiObjcCallback called: %@", data);
        [self setupCamera];
        //responseCallback(@"Response from task-startObjcCallback");
        self.myresponseCallback = responseCallback;
    }];


}

-(void)loadRequestURL
{
    NSString * tokenStr = [NSString stringWithFormat:@"%@?token=%@",KHDSProcessURL,[DataEngine sharedDataEngine].deviceToken];
    NSURL* url = [NSURL URLWithString:tokenStr];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.mainwebView loadRequest:request];//加载
}

#pragma mark ---UIWebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request URL = %@",request.URL);
    
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView*)webView //当网页视图已经开始加载一个请求后，得到通知。
{
    
}
-(void)webViewDidFinishLoad:(UIWebView*)webView ;//当网页视图结束加载一个请求之后，得到通知。
{
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error;//当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型。
{
    
}


- (void)didSelectedTabBarItem
{
    NSLog(@"didSelectedTabBarItem =%@",self);
}

-(void)setupCamera
{
    
    RootViewController * rt = [[RootViewController alloc]init];
    rt.delegate = self;
    
    [self presentViewController:rt animated:YES completion:^{
    }];
}



#pragma mark -- scan delegate
- (void)scanResultStr:(NSString *)str
{
//    NSLog(@"response 11111 =%@",str);
    if ([str length] > 0)
    {
        self.myresponseCallback(str);
        
    }

}

@end
