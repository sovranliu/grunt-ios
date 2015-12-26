//
//  HDSMineViewController.m
//  HDMedical
//
//  Created by David on 15-8-10.
//  Copyright (c) 2015年 HD. All rights reserved.
//

#import "HDSMineViewController.h"
#import "UIView+Positioning.h"
#import "TOWebViewController.h"
#import "CMTabBarController.h"

@interface HDSMineViewController ()

@end

@implementation HDSMineViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title      = @"我的";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"home_footbar_icon_dianping" selIconImgName:@"home_footbar_icon_dianping_pressed"];
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
    self.navigationController.navigationBar.hidden = YES;
    [self initMineTableView];
    [self initHeadView];
    [self initLogOutBtnUI];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showRightName)
                                                 name:KHDSaleAlreadLogin object:nil];
}

- (void)initMineTableView
{
    self.mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 350) style:UITableViewStylePlain];
    [self.mineTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mineTableView.delegate = self;
    self.mineTableView.dataSource = self;
    self.mineTableView.showsHorizontalScrollIndicator = NO;
    self.mineTableView.showsVerticalScrollIndicator= NO;
    self.mineTableView.bounces = YES;
    self.mineTableView.alwaysBounceVertical = NO;
    self.mineTableView.alwaysBounceHorizontal = NO;
    [self.view addSubview:self.mineTableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setHiddenTabBarView:NO];
}

- (void)initHeadView
{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 170)];
    [headView setBackgroundColor:[UIColor colorWithRed:18.0/255.0 green:134.0/255.0 blue:154.0/255.0 alpha:1.0]];
    headView.userInteractionEnabled = YES;
    
    UIImageView * showIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [showIconImgView setImage:[UIImage imageNamed:@"mine_profile_default"]];
    [headView addSubview:showIconImgView];
    [showIconImgView centerToParent];
    [showIconImgView setCenterY:showIconImgView.centerY - 20];
    [showIconImgView setTag:0];
    

    
    UIButton * nickName = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, kScreenW - 80, 40)];
    if ([DataEngine sharedDataEngine].isLogin) {
        [nickName setTitle:[DataEngine sharedDataEngine].name forState:UIControlStateNormal];
    }    
    
    [nickName setTintColor:[UIColor whiteColor]];
    [nickName setBackgroundColor:[UIColor clearColor]];
    [nickName.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [nickName setTag:8];
    [nickName setY:showIconImgView.bottom];
    [headView addSubview:nickName];
    
    
    self.mineTableView.tableHeaderView = headView;
    
}

- (void)initLogOutBtnUI
{
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(20, self.view.bottom - 110, kScreenW - 40, 40)];
    [confirmBtn addTarget:self action:@selector(loginoutAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"退出登入" forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 3.0f;
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor colorWithRed:18.0/255.0 green:134.0/255.0 blue:154.0/255.0 alpha:1.0]];
    [self.view addSubview:confirmBtn];
}

- (void)loginoutAction:(id)sender
{
    NSLog(@"loginoutAction");
    
    
    [DataEngine sharedDataEngine].isLogin = NO;
    
    [DataEngine sharedDataEngine].deviceToken = @"";
    [DataEngine sharedDataEngine].name = @"";
    [DataEngine sharedDataEngine].userName = @"";
    [DataEngine sharedDataEngine].userGlobalId = @"";
    
    
    // 保存本地，记录登陆状态
    [[DataEngine sharedDataEngine] saveUserBaseInfoData];
    
    [(CMTabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController  setSelectedVCIndex:0];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KHDSaleAlreadLogout object:nil];
    
    
}

- (void)showRightName
{
    UIButton * nickName = [self.view viewWithTag:8];
    [nickName setTitle:[DataEngine sharedDataEngine].name forState:UIControlStateNormal];
}


#pragma mark -列表处理


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifierStr = @"BasicInforIdentifier";
    
    UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierStr];
    if (tableCell == nil)
    {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierStr];
    }
    
    if (indexPath.row == 0)
    {
       [tableCell.textLabel setText:@"关于我们"];
    }else if (indexPath.row == 1)
    {
        [tableCell.textLabel setText:@"热线电话"];
    }else
    {
        [tableCell.textLabel setText:@"问卷调查"];
    }

    
    [tableCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return tableCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRow");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        NSString * aboutUS = @"http://cdn.oss.wehop-resources-beta.wehop.cn/sales/app/sites/v-1/about_us.html";
        TOWebViewController * webViewVC = [[TOWebViewController alloc] initWithURLString:aboutUS];
        [self.navigationController pushViewController:webViewVC animated:YES];
        self.navigationController.navigationBar.hidden = NO;
        [self setHiddenTabBarView:YES];
        
    }else if (indexPath.row == 1)
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"13816202676"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else
    {
        NSString * askquestion = @"http://www.diaoyanbao.com/answer/load/7uHEqXF8";
        TOWebViewController * webViewVC = [[TOWebViewController alloc] initWithURLString:askquestion];
        [self.navigationController pushViewController:webViewVC animated:YES];
        self.navigationController.navigationBar.hidden = NO;
        [self setHiddenTabBarView:YES];
    }
    
}



- (void)didSelectedTabBarItem
{
    NSLog(@"didSelectedTabBarItem =%@",self);
}

@end
