//
//  HDSMainViewController.m
//  HDMedical
//
//  Created by David on 15-8-10.
//  Copyright (c) 2015年 HD. All rights reserved.
//

#import "HDSMainViewController.h"

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
