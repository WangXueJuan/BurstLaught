//
//  VerHotViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "VerHotViewController.h"
#import "AFNetworking.h"
#import "VertHotTableViewCell.h"
#import "verHotModel.h"
#import "verHotDetailTableViewController.h"
#import "GifView.h"

@interface VerHotViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation VerHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //将tableView添加到视图上
    [self.view addSubview:self.tableView];
    //请求网路数据
    [self requestData];
    
    
}

//请求网路数据
- (void)requestData {
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    [sessionManger GET:[NSString stringWithFormat:@"%@", kVerHotList] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responDic = responseObject;
        NSMutableArray *listArray = responDic[@"list"];
        NSLog(@"%ld",listArray.count);
        NSMutableArray *textArray = [NSMutableArray new];
        for (NSDictionary *dict in listArray) {
            verHotModel *verModel = [[verHotModel alloc] initWithDictionary:dict];
            [textArray addObject:verModel];
            [self.dataArray addObject:textArray];
        }
        
        
        [self.tableView reloadData];
        
       
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}

#pragma mark ---------------------------- UITableViewDataSource
//分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

//重用机制
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    VertHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[VertHotTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableArray *array = self.dataArray[indexPath.section];
    cell.verModel = array[indexPath.row];

    return cell;
}


#pragma mark ----------------------------  UITableViewDelegate


//cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *detaildStorboard = [UIStoryboard storyboardWithName:@"verHotDetail" bundle:nil];
    verHotDetailTableViewController *hotVC = detaildStorboard.instantiateInitialViewController;
    NSMutableArray *groupArray = self.dataArray[indexPath.section];
    hotVC.verModel = groupArray[indexPath.row];
    
    [self.navigationController pushViewController:hotVC animated:YES];


}

//返回cell的自定义高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = self.dataArray[indexPath.section];
    verHotModel *hotModel = array[indexPath.row];
    CGFloat cellHeight  = [VertHotTableViewCell getCellHeightMode:hotModel];
    return cellHeight + 20;
    

}


#pragma mark ----------------------------- 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 180) style:UITableViewStylePlain];
        //设置属性
//        self.tableView.rowHeight = 250.0;
        //设置代理
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;

}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
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
