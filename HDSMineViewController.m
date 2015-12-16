//
//  HDSMineViewController.m
//  HDMedical
//
//  Created by David on 15-8-10.
//  Copyright (c) 2015年 HD. All rights reserved.
//

#import "HDSMineViewController.h"

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
    
}

- (void)didSelectedTabBarItem
{
    NSLog(@"didSelectedTabBarItem =%@",self);
}

@end
