//
//  qiushiModel.h
//  BurstLaugh
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface qiushiModel : NSObject
@property (nonatomic, strong) NSString *iconImage; //头像
@property (nonatomic, strong) NSString *login; //用户名
@property (nonatomic, strong) NSString *content; //文本
@property (nonatomic, strong) NSString *down; //踩
@property (nonatomic, strong) NSString *up; //赞
@property (nonatomic, strong) NSString *comments_count; //评论次数
@property (nonatomic, strong) NSString *share_count; //分享次数
@property (nonatomic, strong) NSString *iconId;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *contentId;

- (instancetype)initWithDictionary:(NSDictionary *)dic number:(int)number;



@end
