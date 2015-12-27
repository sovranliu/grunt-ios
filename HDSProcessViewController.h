//
//  HDSProcessViewController.h
//  HDMedical
//
//  Created by David on 15-8-10.
//  Copyright (c) 2015年 HD. All rights reserved.
//

#import "CMViewController.h"
#import "RootViewController.h"
#import "WebViewJavascriptBridge.h"
typedef void (^WVJBResponseCallback)(id responseData);

@interface HDSProcessViewController : CMViewController<RootViewControllerDelegate,UIWebViewDelegate>
@property (strong,atomic)UIWebView * mainwebView;
@property (strong, nonatomic) WebViewJavascriptBridge *javascriptBridge;
@property (strong,nonatomic)WVJBResponseCallback myresponseCallback;
@end
