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

        self.picture = dic[@"image"];
        self.text = dic[@"title"];
        self.playcount = [dic[@"play_count"] stringValue];
        self.up = [dic[@"vote_count"] stringValue];
        self.video_url = dic[@"first_url"];
        self.duration = [dic[@"play_time"] floatValue];
        self.down = [dic[@"visiable"] stringValue];
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
