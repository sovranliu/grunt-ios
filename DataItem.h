//
//  DataItem.h
//  LCBIphone
//
//  Created by David on 15-1-2.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataItem : NSObject

@end

// 首页咨询
@interface DetailNewsData : NSObject
@property(nonatomic,strong)NSString * newsID;
@property(nonatomic,strong)NSString * imgurl;
@property(nonatomic,strong)NSString * otime;
@property(nonatomic,strong)NSString * source;
@property(nonatomic,strong)NSString * summary;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * url;

@end
