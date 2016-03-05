//
//  verHotModel.m
//  BurstLaugh
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "verHotModel.h"

@implementation verHotModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        //获取内容
        self.text = dict[@"text"];
        //获取内容图片
        NSDictionary *imageDic = dict[@"image"];
        NSMutableArray *urlArray = [NSMutableArray new];
        if (![imageDic isEqual:[NSNull null]]) {
            self.height = [imageDic[@"height"] integerValue];
            self.width = [imageDic[@"width"] integerValue];
            urlArray = imageDic[@"big"];
            self.textImage = urlArray[0];
        }
        //获取头像
        NSDictionary *uDic = dict[@"u"];
        //获取用户名
        self.name = uDic[@"name"];
        self.uid = uDic[@"uid"];
        NSMutableArray *uArray = [NSMutableArray new];
        if (![uDic isEqual:[NSNull null]]) {
            uArray = uDic[@"header"];
            self.icon = uArray[0];
        }
        //获取评论
        self.comment = dict[@"comment"];
        self.up = dict[@"up"];
        self.down = dict[@"down"];
        self.share_url = dict[@"share_url"];
        self.passtime = dict[@"passtime"];
        
       
    }
    return self;

}


@end
