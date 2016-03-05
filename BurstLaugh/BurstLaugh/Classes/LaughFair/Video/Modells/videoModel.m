//
//  videoModel.m
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "videoModel.h"

@implementation videoModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.text = dic[@"text"];
        self.down = dic[@"down"];
        self.up = dic[@"up"];
        NSDictionary *videoDic = dic[@"video"];
        NSMutableArray *videoArray = [NSMutableArray new];
        NSMutableArray *thumbnailArray = dic[@"thumbnail"];
        if (![videoDic isEqual:[NSNull null]]) {
            videoArray = videoDic[@"video"];
            self.video_url = videoArray[0];
            thumbnailArray = videoDic[@"thumbnail"];
            self.picture = thumbnailArray[0];
            self.duration = [videoDic[@"duration"] floatValue];
            [self covertTime:self.duration];
            self.playcount = videoDic[@"playcount"];
        }
        NSDictionary *uDic = dic[@"u"];
        NSMutableArray *array = [NSMutableArray new];
        if (![uDic isEqual:[NSNull null]]) {
            array = uDic[@"header"];
            self.iconImage = array[0];
        }
        
    }
    
    return self;
}

//时间转换
- (NSString *)covertTime:(CGFloat)second {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/60 >= 1) {
        [fmt setDateFormat:@"HH:mm:ss"];
    } else {
        [fmt setDateFormat:@"mm:ss"];
    }
    NSString *showTimeNew = [fmt stringFromDate:d];
    return showTimeNew;
}

@end
