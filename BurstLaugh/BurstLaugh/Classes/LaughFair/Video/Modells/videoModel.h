//
//  videoModel.h
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface videoModel : NSObject
//描述内容
@property (nonatomic, strong) NSString *text;
//图片
@property (nonatomic, strong) NSString *picture;
//时长
@property (nonatomic, assign) double duration;
//播放数
@property (nonatomic, strong) NSString *playcount;
//视频地址
@property (nonatomic, strong) NSString *video_url;
@property (nonatomic, strong) NSString *down;
@property (nonatomic, strong) NSString *up;
@property (nonatomic, strong) NSString *iconImage;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
