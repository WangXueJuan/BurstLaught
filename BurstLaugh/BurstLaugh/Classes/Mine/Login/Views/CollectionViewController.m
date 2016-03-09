//
//  CollectionViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "CollectionViewController.h"
#import "QiuShiTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "HWTools.h"
#import "DataBaseManger.h"
@interface CollectionViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGFloat cellHeight;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) DataBaseManger *dbManger;
@property (nonatomic, strong) qiushiModel *model;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    [self showBackButtonWithImage:@"back"];
    
    self.dic = [[NSMutableDictionary alloc] init];
    self.array = [[NSArray alloc] init];
    //初始化数据库对象
    self.dbManger = [DataBaseManger sharedInstance];
    self.dic = [self.dbManger selectAllQiuShiModel];
    self.model = [[qiushiModel alloc] initWithDictionary:self.dic];
    [self.dataArray addObject:self.model];
    
     //添加tableView
    [self.view addSubview:self.tableView];


   
}

#pragma mark--------------------------- 协议方法
//重用机制
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    QiuShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QiuShiTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
   
    cell.qiushiModel = self.dataArray[indexPath.row];
    
    return cell;
}

//返回分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   NSLog(@"67890-=%ld",self.dataArray.count);
    
    
    return self.dataArray.count;
}

//返回文本高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    qiushiModel *model = self.dataArray[indexPath.row];
    CGFloat cellH = [HWTools getTextHeightWithText:model.content];
    return cellH + 80;;
    
}

#pragma mark -------------------------- 懒加载
-(UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kHeight - 80) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 200;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(qiushiModel *)collectModel {
    if (_collectModel == nil) {
        self.collectModel = [[qiushiModel alloc] init];
    }
    return _collectModel;
}

-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray new];
    }
    return _dataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
