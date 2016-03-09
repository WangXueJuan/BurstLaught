//
//  qiushiModel.m
//  BurstLaugh
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "qiushiModel.h"

@implementation qiushiModel
-(instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.contentId = dic[@"id"];
        self.content = dic[@"content"];
        self.comments_count = dic[@"comments_count"];
        self.share_count = dic[@"share_count"];
        NSDictionary *userDic = dic[@"user"];
        NSString *preId;
        if (![userDic isEqual:[NSNull null]]) {
            self.login = userDic[@"login"];
            self.iconId = [NSString stringWithFormat:@"%@", userDic[@"id"]];
            self.icon = userDic[@"icon"];
        }
        NSDictionary *votesDic = dic[@"votes"];
        self.down = votesDic[@"down"];
        self.up = votesDic[@"up"];
        //截取id前四位
        preId = [self.iconId substringToIndex:4];
        //拼接id头像
        self.iconImage = [NSString stringWithFormat:@"http://img.qiushibaike.com/system/avtnew/%@/%@/thumb/%@",preId,self.iconId, self.icon];
        
    }
    return self;
}






@end
