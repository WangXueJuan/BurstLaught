//
//  DataBaseManger.m
//  BurstLaugh
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "DataBaseManger.h"
#import <sqlite3.h>

@interface DataBaseManger ()
{
    NSString *dataBasePath;   //6.数据库路径
}

@end

@implementation DataBaseManger

//2.实现单例，创建静态单例对象（DataBaseManger），初始化为 nil
static DataBaseManger *dbManger = nil;
+ (DataBaseManger *)sharedInstance {
    //如果单例为空，就去创建一个
    if (dbManger == nil) {
        dbManger = [[DataBaseManger alloc] init];
    }
    return dbManger;
}

//4.实现方法
//创建一个静态数据库实例对象
static sqlite3 *dataBase = nil;

//创建数据库
- (void)creatDataBase {
    //获取应用程序沙盒路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    dataBasePath = [documentsPath stringByAppendingString:@"/Mango.sqlite"];
    
    NSLog(@"%@",dataBasePath);
    
}


//打开数据库的方法
-(void)openDataBase {
    //如果数据库存在，就直接返回，如果不存在，就去创建一个
    if (dataBase != nil) {
        return;
    }
    //若数据库为空则创建数据库
    [self creatDataBase];
    
    //如果数据库已经存在，就是打开操作，不存在，就是创建操作
    int result = sqlite3_open([dataBasePath UTF8String], &dataBase);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        //7.打开成功后去创建数据库表
        [self creatDataBaseTable];
    } else {
        NSLog(@"数据库打开失败");
    }
    

}


//8.创建数据库表
-(void)creatDataBaseTable {
    //建表语句
    NSString *sql = @"CREATE TABLE QiuShiModel (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, icon TEXT, content TEXT, up TEXT, down TEXT, comment TEXT, shared TEXT)";
    //9.执行SQL语句
    char *err = nil;
    sqlite3_exec(dataBase, [sql UTF8String], nil, nil, &err);
    
    
}

//关闭数据库的方法
-(void)closeDataBase {
    int result = sqlite3_close(dataBase);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        dataBase = nil;
    } else {
        NSLog(@"数据库关闭失败");
    }
    
}

#pragma mark ------------------ 10.数据库常用操作
//增
-(void)insertIntoNewQuiShiModel:(qiushiModel *)qiushi {
    //10.打开数据库
    [self openDataBase];
    //创建一个存储sql语句的指针
    sqlite3_stmt *stmt = nil;
    //sql语句
    NSString *sql = @"INSERT INTO QiuShiModel (name,icon,content,up,down,comment,shared) VALUES (?,?,?,?,?,?,?)";
    //验证sql语句
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //开始绑定
        
        //绑定第一个  name
        sqlite3_bind_text(stmt, 1, [qiushi.login UTF8String], -1, NULL);
        //绑定第二个  icon
        sqlite3_bind_text(stmt, 2, [qiushi.iconImage UTF8String], -1, NULL);
        //绑定第三个  content
        sqlite3_bind_text(stmt, 3, [qiushi.content UTF8String], -1, NULL);
        //绑定第四个  up
        NSString *up = [NSString stringWithFormat:@"%@",qiushi.up];
        sqlite3_bind_text(stmt, 4, [up UTF8String], -1, NULL);
        //绑定第五个  down
        NSString *down = [NSString stringWithFormat:@"%@",qiushi.down];
        sqlite3_bind_text(stmt, 5, [down UTF8String], -1, NULL);
        //绑定第六个  comment
        NSString *comment = [NSString stringWithFormat:@"%@",qiushi.comments_count];
        sqlite3_bind_text(stmt, 6, [comment UTF8String], -1, NULL);
        //绑定第七个  shared
        NSString *shared = [NSString stringWithFormat:@"%@",qiushi.share_count];
        sqlite3_bind_text(stmt, 7, [shared UTF8String], -1, NULL);
        
        //执行
        sqlite3_step(stmt);

    } else {
        NSLog(@"sql语句有问题");
    }
    
    //删除释放
    sqlite3_finalize(stmt);

}

//删
-(void)deleteQiuShiModelWithContent:(NSString *)content {
    //创建一个存储sql语句的指针变量
    sqlite3_stmt *stmt = nil;
    //sql语句
    NSString *sqlStr = @"delete from QiuShiModel where content = ? ";
    //验证语句
    int result = sqlite3_prepare_v2(dataBase, [sqlStr UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"sql语句没有问题");
        //绑定第三个问号的值 content
        sqlite3_bind_text(stmt, 3, [content UTF8String], -1, nil);
        //执行
        sqlite3_step(stmt);
        
    } else {
        NSLog(@"删除失败");
    }
    
    //释放
    sqlite3_finalize(stmt);
    
}

//查
-(NSMutableDictionary *)selectAllQiuShiModel {
    [self openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"SELECT * FROM QiuShiModel";
    //验证语句
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    //创建一个可变字典，存储查询出来的数据
    NSMutableDictionary *QiuShiDic = [NSMutableDictionary new];
   
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //把每一次查询出来的数据添加到字典中
            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *icon = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString *up = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            NSString *down = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            NSString *comment = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            NSString *shared = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            
            [QiuShiDic setValue:name forKey:@"name"];
             [QiuShiDic setValue:icon forKey:@"icon"];
            [QiuShiDic setValue:content forKey:@"content"];
            [QiuShiDic setValue:up forKey:@"up"];
            [QiuShiDic setValue:down forKey:@"down"];
            [QiuShiDic setValue:comment forKey:@"comment"];
            [QiuShiDic setValue:shared forKey:@"shared"];
        }
    } else {
        NSLog(@"查询语句有错误");
    }
    sqlite3_finalize(stmt);
    return QiuShiDic;
}










@end
