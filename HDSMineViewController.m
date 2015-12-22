//
//  HDSMineViewController.m
//  HDMedical
//
//  Created by David on 15-8-10.
//  Copyright (c) 2015年 HD. All rights reserved.
//

#import "HDSMineViewController.h"
#import "UIView+Positioning.h"

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
- (void)initExtendedData
{
}

- (void)loadUIData
{
    self.navigationController.navigationBar.hidden = YES;
    [self initMineTableView];
    [self initHeadView];
    [self initLogOutBtnUI];
}

- (void)initMineTableView
{
    self.mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 300) style:UITableViewStylePlain];
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
    [nickName setTitle:@"王莎莎 00008" forState:UIControlStateNormal];
    
    [nickName setTintColor:[UIColor whiteColor]];
    [nickName setBackgroundColor:[UIColor clearColor]];
    [nickName.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [nickName setTag:0];
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
}


#pragma mark -列表处理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    }

    
    [tableCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return tableCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRow");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    
//    myhtml5Item * item = [self.localArray objectAtIndex:indexPath.row];
//    NSString * urlStr = item.url;
//    NSString *encodedString=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    TOWebViewController * webViewVC = [[TOWebViewController alloc] initWithURLString:encodedString];
//    [self setHiddenTabBarView:YES];
//    [self.navigationController pushViewController:webViewVC animated:YES];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)didSelectedTabBarItem
{
    NSLog(@"didSelectedTabBarItem =%@",self);
}

@end
