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
        NSDictionary *authorDic = dic[@"author"];
        if (![authorDic isEqual:[NSNull null]]) {
            self.avatar = authorDic[@"avatar"];
            self.name = authorDic[@"name"];
        }
        NSDictionary *contDic = dic[@"content"];
        if (![contDic isEqual:[NSNull null]]) {
            self.text = contDic[@"text"];
        }
        self.like = dic[@"like"];
        self.unlike = dic[@"unlike"];
        self.shared = dic[@"shared"];
        self.comment = dic[@"comment"];
        
    }
    return self;
}
@end
