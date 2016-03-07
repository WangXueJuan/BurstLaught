//
//  QiuShiDetailModell.m
//  BurstLaugh
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "QiuShiDetailModell.h"

@implementation QiuShiDetailModell

-(instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        NSDictionary *userDic = dic[@"user"];
        NSString *preId;
        if (![userDic isEqual:[NSNull null]]) {
            self.login = userDic[@"login"];
            self.iconId = [NSString stringWithFormat:@"%@", userDic[@"id"] ];
            self.icon = userDic[@"icon"];
            
        }
        //截取id前四位
        preId = [self.iconId substringToIndex:4];
        //拼接id头像
        self.iconImage = [NSString stringWithFormat:@"http://img.qiushibaike.com/system/avtnew/%@/%@/thumb/%@",preId,self.iconId, self.icon];
    
        self.content = dic[@"content"];
    }
    return self;
}

@end
