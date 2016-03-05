//
//  verHotModel.h
//  BurstLaugh
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface verHotModel : NSObject
@property (nonatomic, strong) NSString *name;   //用户名
@property (nonatomic, strong) NSString *icon;   //用户头像
@property (nonatomic, strong) NSString *text;   //文本内容
@property (nonatomic, strong) NSString *textImage;  //图片
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *passtime;
@property (nonatomic, strong) NSString *up;
@property (nonatomic, strong) NSString *down;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *share_url;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
