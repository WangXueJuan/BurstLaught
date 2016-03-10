//
//  DataBaseManger.h
//  BurstLaugh
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <Foundation/Foundation.h>
//引入需要被管理的model
#import "qiushiModel.h"

@interface DataBaseManger : NSObject

//1.用单例创建数据库管理对象
+ (DataBaseManger *)sharedInstance;
#pragma mark----------------------- 3.数据库基本操作方法
//创建数据库
- (void)creatDataBase;
//创建数据库表
- (void)creatDataBaseTable;
//打开数据库
- (void)openDataBase;
//关闭数据库
- (void)closeDataBase;

//增
- (void)insertIntoNewQuiShiModel:(qiushiModel *)qiushi;
//删
- (void)deleteQiuShiModelWithContent:(NSString *)content;
//查
//查询所有列表信息
- (NSMutableArray *)selectAllQiuShiModel;


@end
