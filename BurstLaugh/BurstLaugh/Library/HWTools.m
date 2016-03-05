//
//  HWTools.m
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "HWTools.h"

@implementation HWTools
+(NSString *)getDataFromString:(NSString *)timesTemp {
    NSTimeInterval time = [timesTemp doubleValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    return timeStr;
    
}

//获取系统当前的时间
//创建一个NSDateFormatter现实刷新时间
+(NSDate *)getSystemNowTime {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dataStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:dataStr];
    return date;
}

@end
