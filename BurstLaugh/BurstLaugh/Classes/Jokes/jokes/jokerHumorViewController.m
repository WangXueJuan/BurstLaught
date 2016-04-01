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
#import "HWTools.h"
#import "ProgressHUD.h"
#import "CollectionViewController.h"
#import "DataBaseManger.h"
@interface jokerHumorViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate, collectDelegate>
{
    NSInteger _pageCount;
    
}

@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL refreshing;

@end

@implementation jokerHumorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pageCount = 1;
    [self.view addSubview:self.tableView];
    [self requestData];
    
}

- (void)requestData {
    [ProgressHUD show:@"正在加载数据"];
    
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    
    sessionManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [sessionManger GET:[NSString stringWithFormat:@"%@&page=%ld",kJokesList, (long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *itemDic = responseObject;
        NSMutableArray *itemsArray = itemDic[@"items"];
        for (NSDictionary *dic in itemsArray) {
            jokerModel *model = [[jokerModel alloc] initWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        [ProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//返回分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    QiuShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QiuShiTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    jokerModel *model = self.dataArray[indexPath.row];
    cell.jokerModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
    
}

//cell的协议方法
-(void)collectionClick:(UIButton *)btn {
    if (btn.tag == 9) {
        [ProgressHUD showSuccess:@"收藏成功"];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:@"暂时没有详情，您可以点击收藏，谢谢!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *canAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:canAction];
    [self presentViewController:alert animated:YES completion:nil];


}

//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    jokerModel *model = self.dataArray[indexPath.row];
    CGFloat cellHeight = [QiuShiTableViewCell getCellHeightJokerModel:model];
    return cellHeight + 20;
}

//下拉刷新
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
    _pageCount = 1;
    self.refreshing = NO;
    [self performSelector:@selector(requestData) withObject:nil afterDelay:1.0];

}

//上拉加载
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
    _pageCount += 1;
    self.refreshing = YES;
    [self performSelector:@selector(requestData) withObject:nil afterDelay:1.0];
}
//获取系统时间
-(NSDate *)pullingTableViewRefreshingFinishedDate {
    return [HWTools getSystemNowTime];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView tableViewDidEndDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView tableViewDidScroll:scrollView];
}

//懒加载
-(PullingRefreshTableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 12, kWidth, kHeight - 50) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}

-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


-(void)viewWillAppear:(BOOL)animated {
    [ProgressHUD dismiss];
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
