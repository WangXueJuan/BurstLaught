//
//  jokerModel.m
//  BurstLaugh
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "jokerModel.h"

@implementation jokerModel
-(instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        NSString *preId;
        NSDictionary *authorDic = dic[@"user"];
        if (![authorDic isEqual:[NSNull null]]) {
            self.name = authorDic[@"login"];
            self.iconId = [NSString stringWithFormat:@"%@", authorDic[@"id"]];
            self.icon = authorDic[@"icon"];
        }
        self.text = dic[@"content"];
        NSDictionary *votesD = dic[@"votes"];
        if (![votesD isEqual:[NSNull null]]) {
            self.like = votesD[@"up"];
            self.unlike = votesD[@"down"];
        }
        self.shared = dic[@"share_count"];
        self.comment = dic[@"comments_count"];
        self.format  =dic[@"format"];
        //拼接头像
        //截取id前四位
        preId = [self.iconId substringToIndex:4];
        //拼接id头像
        self.iconImage = [NSString stringWithFormat:@"http://img.qiushibaike.com/system/avtnew/%@/%@/thumb/%@",preId,self.iconId, self.icon];
        
    }
    return self;
}
@end
