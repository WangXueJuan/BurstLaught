//
//  QiuShiDetailModell.h
//  BurstLaugh
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiuShiDetailModell : NSObject
@property (nonatomic, copy) NSString *content;  //评论内容
@property (nonatomic, copy) NSString *login;   //评论人
@property (nonatomic, strong) NSString *iconId;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *iconImage; //拼接id头像
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
