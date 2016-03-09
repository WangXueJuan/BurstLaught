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
    //创建一个NSDataFormatter显示刷新时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:dateStr];
    return date;
}


//返回文本的最大高度
+ (CGFloat)getTextHeightWithText:(NSString *)txtlabel{
    //计算方法
    CGRect textRect = [txtlabel boundingRectWithSize:CGSizeMake(kWidth * 0.65, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    return textRect.size.height;
    
}

@end
