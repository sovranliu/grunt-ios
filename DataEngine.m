//
//  DataEngine.m
//  LeCakeIphone
//
//  Created by David on 14-10-27.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "DataEngine.h"
#import "AFNetworking.h"
#import "Utils.h"


@implementation DataEngine

+(DataEngine *)sharedDataEngine
{
    static DataEngine *sharedDataEngineInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedDataEngineInstance = [[self alloc] init];
    });
    
    return sharedDataEngineInstance;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self initUserInfo];
        [self loadUserBaseInfoData];
        
        return self;
    }
    return self;
}

#pragma mark 初始化设置用户基本信息
- (void)initUserInfo
{
    NSString *filePath = [Utils getFilePath:@"user.plist"];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    if (!userDic)
    {
        userDic = [[NSMutableDictionary alloc] init];
        
        [userDic setValue:@"" forKey:@"kPhoneNumberKey"];
        
        [userDic setValue:[NSNumber numberWithBool:NO] forKey:@"kIsLoginKey"];
        
        [userDic setValue:@"" forKey:@"KDeviceToken"];
        [userDic setValue:[NSNumber numberWithBool:YES] forKey:@"kIsFirstInstructionKey"];
        
        [userDic writeToFile:filePath atomically:YES];
    }
}

#pragma 装载用户基本信息
- (void)loadUserBaseInfoData
{
    NSString *filepath = [Utils getFilePath:@"user.plist"];
    
    if (filepath != nil)
    {
        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
        
        self.isLogin = [userDic valueForKey:@"kIsLoginKey"] ? [[userDic valueForKey:@"kIsLoginKey"] boolValue] : NO;
        
        self.deviceToken = [userDic valueForKey:@"KDeviceToken"];
        self.userName = [userDic valueForKey:@"kPhoneNumberKey"];
        self.isFirstInstruction = [[userDic valueForKey:@"kIsFirstInstructionKey"] boolValue];
    }
}

- (void)saveUserBaseInfoData
{
    NSString *filepath = [Utils getFilePath:@"user.plist"];
    
    if (filepath != nil)
    {
        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
        
        if (userDic != nil)
        {
            
            if (self.isLogin)
            {
                [userDic setValue:[NSNumber numberWithBool:self.isLogin] forKey:@"kIsLoginKey"];
                [userDic setValue:self.userName forKey:@"kPhoneNumberKey"];
                [userDic setValue:self.deviceToken forKey:@"KDeviceToken"];
            }
            else
            {
                [userDic setValue:[NSNumber numberWithBool:self.isLogin] forKey:@"kIsLoginKey"];
                [userDic setValue:@"" forKey:@"kPhoneNumberKey"];
            }
            
            
            if (!self.isFirstInstruction) {
                [userDic setValue:[NSNumber numberWithBool:NO] forKey:@"kIsFirstInstructionKey"];
            }
            
            [userDic writeToFile:filepath atomically:YES];
        }
    }
}



// http get请求
- (void)reqAsyncHttpGet:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo withReqTag:(int)tag
{
    NSDictionary * tmpUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"tag", nil];
    
     __weak __typeof(CMViewController)*weakSelf = target;
    
    AFHTTPRequestOperationManager * requestOpeManager = [AFHTTPRequestOperationManager manager];
    [requestOpeManager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf reflashTargetUI:strongSelf responseData:responseObject withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         operation.userInfo = tmpUserInfo;
         __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf httpResponseError:strongSelf errorInfo:error withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
        
    }];
}

// http post请求
- (void)reqAsyncHttpPost:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo withReqTag:(int)tag
{
    NSDictionary * tmpUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"tag", nil];
    
    __weak __typeof(CMViewController)*weakSelf = target;
    
    AFHTTPRequestOperationManager * requestOpeManager = [AFHTTPRequestOperationManager manager];
    [requestOpeManager POST:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf reflashTargetUI:strongSelf responseData:responseObject withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf httpResponseError:strongSelf errorInfo:error withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];

    }];
}
// http json请求
- (void)reqJsonHttp:(id)target urlStr:(NSString *)jsonURL withReqTag:(int)tag
{
     __weak __typeof(CMViewController)*weakSelf = target;
    NSDictionary * tmpUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"tag", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:jsonURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        // json格式化
        NSError * error;
        NSJSONSerialization * jonsdata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];

        [strongSelf parseJsonDataInUI:strongSelf jsonData:jonsdata withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf httpResponseError:strongSelf errorInfo:error withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
    }];
}
@end
