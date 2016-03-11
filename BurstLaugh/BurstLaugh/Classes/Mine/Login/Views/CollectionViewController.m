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
@property (nonatomic, strong) NSMutableArray *dataArray1;
@property (nonatomic, strong) DataBaseManger *dbManger;
@property (nonatomic, strong) qiushiModel *model;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *array1;
@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self showBackButtonWithImage:@"back"];
    
     //添加tableView
    [self.view addSubview:self.tableView];
    //初始化数据库对象
    self.dbManger = [DataBaseManger sharedInstance];
    //将查询出来的数据添加到数组
    self.array = [self.dbManger selectAllQiuShiModel];
    

    for (NSDictionary *dic in self.array) {
        self.model = [[qiushiModel alloc] initWithDictionary:dic number:1];
        [self.dataArray addObject:self.model];
        
    }
    
 
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
    qiushiModel *qiuModel = self.dataArray[indexPath.row];
    cell.qiushiModel = qiuModel;
    
    return cell;
}

//返回分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

//返回文本高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    qiushiModel *model = self.dataArray[indexPath.row];
    CGFloat cellH = [HWTools getTextHeightWithText:model.content];
    return cellH + 80;;
    
}

//处于可编辑状态
-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [self.tableView setEditing:YES animated:YES];
}

//先指定可删除的行数
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//指定删除样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
         qiushiModel *deModel = self.dataArray[indexPath.row];
        DataBaseManger *dbManger = [DataBaseManger sharedInstance];
        [dbManger deleteQiuShiModelWithContent:deModel.content];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewAutomaticDimension];


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

-(NSMutableArray *)array {
    if (_array == nil) {
        self.array = [NSMutableArray new];
    }
    return _array;
}

-(NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray new];
    }
    return _dataArray1;
}

-(NSMutableArray *)array1 {
    if (_array1 == nil) {
        self.array1 = [NSMutableArray new];
    }
    return _array1;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
