//
//  HDSMainViewController.m
//  HDMedical
//
//  Created by David on 15-8-10.
//  Copyright (c) 2015年 HD. All rights reserved.
//

#import "HDSMainViewController.h"
#import "HDSLoginViewController.h"

@interface HDSMainViewController ()

@end

@implementation HDSMainViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title      = @"首页";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"home_footbar_icon_dianping" selIconImgName:@"home_footbar_icon_dianping_pressed"];
        //[self createTabBarItem:self.title iconImgName:nil selIconImgName:nil];
        
    }
    return self;
}
- (void)initExtendedData
{
    //self.headerDic = [[NSMutableDictionary alloc] initWithCapacity:6];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(advHaveRemovedAction:)
//                                                 name:KHDMedicalADVImg object:nil];
}

- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:KHDMedicalADVImg object:nil];
}


- (void)loadUIData
{
    if (![DataEngine sharedDataEngine].isLogin)
    {
        HDSLoginViewController * loginVC = [[HDSLoginViewController alloc] init];
        
        UINavigationController * rootNavigationVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:rootNavigationVC animated:YES completion:nil];
        
    }
    self.mainwebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH- 49)];
    self.mainwebView.delegate = self;
    self.mainwebView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    //self.mainwebView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    NSURL* url = [NSURL URLWithString:@"http://www.baidu.com"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.mainwebView loadRequest:request];//加载
    [self.view addSubview:self.mainwebView];
    
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
