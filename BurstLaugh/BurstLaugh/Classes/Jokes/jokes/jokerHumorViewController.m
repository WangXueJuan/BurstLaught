//
//  jokerHumorViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "jokerHumorViewController.h"
#import "AFNetworking.h"
#import "PullingRefreshTableView.h"
#import "QiuShiTableViewCell.h"
@interface jokerHumorViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate>
@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation jokerHumorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self requestData];
    
}

- (void)requestData {
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
//    sessionManger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManger GET:kJokesList parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *itemArray = responseObject;
        for (NSDictionary *dic in itemArray) {
            jokerModel *model = [[jokerModel alloc] initWithDictionary:dic];
            [self.dataArray addObject:model];
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//返回分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    QiuShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QiuShiTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
//    jokerModel *model = self.dataArray[indexPath.row];
//    cell.jokerModel = model;
    return cell;
    
}

//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {

}

//懒加载
-(PullingRefreshTableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 80, kWidth, kHeight - 120) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    return _tableView;

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
