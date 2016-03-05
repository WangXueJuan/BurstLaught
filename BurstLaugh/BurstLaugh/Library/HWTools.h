//
//  HWTools.h
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HWTools : NSObject
#pragma mark -------------------- 时间转换方法
//通过时间戳转换时间
+ (NSString *)getDataFromString:(NSString *)timesTemp;

//获取系统当前时间
+ (NSDate *)getSystemNowTime;


@end
