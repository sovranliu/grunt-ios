//
//  DataEngine.h
//  LeCakeIphone
//
//  Created by David on 14-10-27.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMViewController.h"

@interface DataEngine : NSObject

// 是否登陆
@property(nonatomic,assign) BOOL  isLogin;

// token
@property(nonatomic,strong)NSString * deviceToken;
// 用户名
@property(nonatomic,strong) NSString * userName;
// 操作指引
@property(nonatomic,assign) BOOL  isFirstInstruction;

// 单态实例
+(DataEngine *)sharedDataEngine;

// 保存注册登录基本用户数据
- (void)saveUserBaseInfoData;

// http get请求
- (void)reqAsyncHttpGet:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo withReqTag:(int)tag;

// http post请求
- (void)reqAsyncHttpPost:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo withReqTag:(int)tag;

// http json请求
- (void)reqJsonHttp:(id)target urlStr:(NSString *)jsonURL withReqTag:(int)tag;

@end
