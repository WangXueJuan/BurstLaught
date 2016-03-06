//
//  jokerModel.h
//  BurstLaugh
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jokerModel : NSObject
@property (nonatomic, strong) NSString *avatar; //用户头像
@property (nonatomic, strong) NSString *name;  //用户名
@property (nonatomic, strong) NSString *text;  //内容
@property (nonatomic, strong) NSString *like;  //喜欢
@property (nonatomic, strong) NSString *unlike;
@property (nonatomic, strong) NSString *comment; //评论
@property (nonatomic, strong) NSString *shared;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
