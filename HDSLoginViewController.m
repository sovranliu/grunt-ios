//
//  HDSLoginViewController.m
//  LCBIphone
//
//  Created by David on 14-12-17.
//  Copyright (c) 2014年 David. All rights reserved.
//

#import "HDSLoginViewController.h"
#import "UIView+Positioning.h"
#import "JSONFormatFunc.h"


#import "Utils.h"

@interface HDSLoginViewController ()

@end

@implementation HDSLoginViewController
- (id)init
{
    self = [super init];
    if (self)
    {
        self.title      = @"登录";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initExtendedData
{
    
}

- (void)loadUIData
{
//    self.navigationController.navigationBar.hidden = YES;
//    
    UIButton *backActionBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backActionBtn setFrame:CGRectMake(10, 30, 40, 30)];
    [backActionBtn setTitle:@"回退" forState:normal];
    [backActionBtn setFont:[UIFont systemFontOfSize:15.0]];
    [backActionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backActionBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backActionBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;

//    [navigationBgView addSubview:backActionBtn];
    
    UIImageView * imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [imgview setImage:[UIImage imageNamed:@"health_history"]];
    [imgview setCenterY:120];
    [imgview setCenterX:self.view.centerX];
    [self.view addSubview:imgview];

    UILabel * titleName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    [titleName setText:@"聚健康"];
    [titleName setTextAlignment:NSTextAlignmentCenter];
    [titleName setTextColor:[UIColor whiteColor]];
    [titleName setCenterX:self.view.centerX];
    [titleName setCenterY:imgview.bottom + 10];
    [self.view addSubview:titleName];
    
    
//    UIColor *color = [UIColor whiteColor];

    UITextField * phoneNumField = [[UITextField alloc] initWithFrame:CGRectMake(20, titleName.bottom + 60, kScreenW - 40, 40)];
    phoneNumField.placeholder = @" 账 号";
    [phoneNumField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    phoneNumField.delegate = self;
    phoneNumField.tag = 11;
    [phoneNumField setBackgroundColor:[UIColor clearColor]];
    phoneNumField.layer.cornerRadius=3.0f;
    phoneNumField.layer.masksToBounds=YES;
    phoneNumField.layer.borderColor=[[UIColor whiteColor]CGColor];
    phoneNumField.layer.borderWidth= 1.0f;
    
//    phoneNumField.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:@"Placeholder Text"
//                                    attributes:@{
//                                                 NSForegroundColorAttributeName: color,
//                                                 NSFontAttributeName : [UIFont fontWithName:@"Roboto-Bold" size:15.0]
//                                                 }
//     ];
    
    [self.view addSubview:phoneNumField];
    
    UITextField * pwsField = [[UITextField alloc] initWithFrame:CGRectMake(20, phoneNumField.bottom + 10, kScreenW - 40, 40)];
    pwsField.placeholder = @" 密 码";
    [pwsField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    pwsField.delegate = self;
    pwsField.tag = 12;
    [pwsField setBackgroundColor:[UIColor clearColor]];
    pwsField.layer.cornerRadius=3.0f;
    pwsField.layer.masksToBounds=YES;
    pwsField.layer.borderColor=[[UIColor whiteColor]CGColor];
    pwsField.layer.borderWidth= 1.0f;
//    pwsField.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:@"Placeholder Text"
//                                    attributes:@{
//                                                 NSForegroundColorAttributeName: color,
//                                                 NSFontAttributeName : [UIFont fontWithName:@"Roboto-Bold" size:15.0]
//                                                 }
//     ];
//    
    [self.view addSubview:pwsField];
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(20, pwsField.bottom + 20, kScreenW - 40, 40)];
    [confirmBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"登  入" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor colorWithRed:18.0/255.0 green:134.0/255.0 blue:154.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:confirmBtn];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:18.0/255.0 green:134.0/255.0 blue:154.0/255.0 alpha:1.0]];
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    
}
-(void)endEdit
{
    UITextField *subView = (UITextField *)[self.view  viewWithTag:11];
    UITextField *subView2 = (UITextField *)[self.view  viewWithTag:12];
    [subView resignFirstResponder];
    [subView2 resignFirstResponder];
}

- (void)loginAction:(id)sender
{

    UITextField * textField =  (UITextField *)[self.view viewWithTag:11];
    UITextField * pwdField =  (UITextField *)[self.view viewWithTag:12];
    NSString *phoneNum = textField.text;
    NSString *pwdStr = pwdField.text;
    if (![Utils checkPhoneNumInput:phoneNum]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号码格式不对，请重新输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if ([pwdStr length] == 0) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
//    //总参数封装
//    NSMutableDictionary * totalParamDic =[[NSMutableDictionary alloc] initWithCapacity:1];
//    [totalParamDic setObject:phoneNum forKey:@"phone"];
//    [totalParamDic setObject:pwdStr forKey:@"password"];
//    [totalParamDic setObject:pwdStr forKey:@"code"];
//    
//    NSMutableString * baseUrl = [NSMutableString stringWithString:KSLFutureBaseURL];
//    [baseUrl appendString:KSLFutureLogin];
//    // 发送数据
//    [[DataEngine sharedDataEngine] reqAsyncHttpPost:self urlStr:baseUrl userInfo:totalParamDic withReqTag:1];
    
    //[[DataEngine sharedDataEngine]  reqHttpWithMockName:@"login" target:self withReqTag:1];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


- (void)backBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
// 返回一个bool值，指明是否允许在按下回车键时结束编辑
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 11)
    {
        [textField resignFirstResponder];
        [[self.view viewWithTag:12] becomeFirstResponder];
    }
    else if (textField.tag == 12)
    {
        [textField resignFirstResponder];
    }
    return YES;
}



- (void)reflashTargetUI:(UIViewController *)vc responseData:(id)responseData withTag:(int)tag
{
    NSLog(@"responseData = %@",responseData);
    if (vc == self&& [responseData isKindOfClass:[NSDictionary class]] && tag == 1)//
    {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"response Data = %@",responseData);
        int code = [[responseData objectForKey:@"code"] intValue];
        NSString * msg =[JSONFormatFunc strValueForKey:@"msg" ofDict:responseData];
        NSLog(@"code = %d,msg =%@",code,msg);
        if (code == 1) // 登陆成功
        {
            
            NSMutableDictionary * logindata = [responseData objectForKey:@"data"];
            NSString * deviceToken          =  [JSONFormatFunc strValueForKey:@"token" ofDict:logindata];
            NSDictionary * loginInfodic =[JSONFormatFunc dictionaryValueForKey:@"info" ofDict:logindata];
            
            //[DataEngine sharedDataEngine].loginUserInfoDic = (NSMutableDictionary *)loginInfodic;
            [DataEngine sharedDataEngine].isLogin = YES;
            
            [DataEngine sharedDataEngine].deviceToken = deviceToken;
            
            // 保存本地，记录登陆状态
            [[DataEngine sharedDataEngine] saveUserBaseInfoData];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:KHDMedicalAlreadLogin object:nil];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else // 登陆失败
        {
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        
    }

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kLCBALREADLOGINNEWS object:nil];
//        
//        [DataEngine sharedDataEngine].isLogin = YES;
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
