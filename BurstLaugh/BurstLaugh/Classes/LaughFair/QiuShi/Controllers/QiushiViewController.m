//
//  QiushiViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "QiushiViewController.h"
#import "AFNetworking.h"
#import "PullingRefreshTableView.h"
#import "QiuShiTableViewCell.h"
#import "HWTools.h"
#import "QiuShiDetailViewController.h"
#import "ProgressHUD.h"
#import "CollectionViewController.h"
#import "MineViewController.h"
@interface QiushiViewController ()<PullingRefreshTableViewDelegate, UITableViewDataSource, UITableViewDelegate,collectDelegate>
{
    NSInteger _pageCount;
    CGFloat cellHeight;
}
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation QiushiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    //请求网络数据
    [self requestData];
    //启动自动刷新
    [self.tableView launchRefreshing];
    
}

- (void)requestData {
    [ProgressHUD show:@"正在加载数据"];
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    sessionManger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManger GET:[NSString stringWithFormat:@"%@page=%ld",kQiushiList,(long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ProgressHUD show:@"数据加载完成"];
        if (self.refreshing) {
            if (self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
        }
        NSDictionary *successDic = responseObject;
        NSMutableArray *itemsArray = successDic[@"items"];
        for (NSDictionary *dic in itemsArray) {
            qiushiModel *model = [[qiushiModel alloc] initWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        
        [self.tableView reloadData];
        [ProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


#pragma mark-------------------- UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    QiuShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QiuShiTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate  =self;

    qiushiModel *model = self.dataArray[indexPath.row];
    cell.qiushiModel = model;
    
    return cell;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}

-(void)collectionClick:(UIButton *)btn {
    if (btn.tag == 9) {
        [ProgressHUD showSuccess:@"收藏成功"];
        CollectionViewController *collectVC = [[CollectionViewController alloc] init];
        QiuShiTableViewCell *cell = (QiuShiTableViewCell *)[[btn superview]superview];
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        qiushiModel *model = self.dataArray[path.row];
        collectVC.collectModel = model;
        //把model中的数据取出来存到defaults里面然后传到收藏界面
        NSString *iconImage = collectVC.collectModel.iconImage;
        NSString *name = collectVC.collectModel.login;
        NSString *up = collectVC.collectModel.up;
        NSString *down = collectVC.collectModel.down;
        NSString *shared = collectVC.collectModel.share_count;
        NSString *comment = collectVC.collectModel.comments_count;
        NSString *content = collectVC.collectModel.content;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:iconImage forKey:@"iconImage"];
        [defaults setValue:name forKey:@"name"];
        [defaults setValue:up forKey:@"up"];
        [defaults setValue:down forKey:@"down"];
        [defaults setValue:shared forKey:@"shared"];
        [defaults setValue:comment forKey:@"comment"];
        [defaults setValue:content forKey:@"content"];
    
        

    }else {
        QiuShiDetailViewController *detailVc = [[QiuShiDetailViewController alloc] init];
        QiuShiTableViewCell *cell = (QiuShiTableViewCell *)[[btn superview]superview];
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        qiushiModel *model = self.dataArray[path.row];
        detailVc.QiushiModel = model;
        detailVc._detailId = model.contentId;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
    
}


#pragma mark -------------------- UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    qiushiModel *model = self.dataArray[indexPath.row];
    cellHeight = [QiuShiTableViewCell getCellHeightModel:model];
    return cellHeight + 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QiuShiDetailViewController *detailVc = [[QiuShiDetailViewController alloc] init];
    qiushiModel *model = self.dataArray[indexPath.row];
    detailVc.QiushiModel = model;
    detailVc._detailId = model.contentId;
    [self.navigationController pushViewController:detailVc animated:YES];
    
}

#pragma mark --------------------- PullingRefreshTableViewDelegate
//上拉加载
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
    _pageCount += 1;
    self.refreshing = NO;
    [self performSelector:@selector(requestData) withObject:nil afterDelay:1.0];

}
//下拉刷新
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
    _pageCount = 1;
    self.refreshing = YES;
    [self performSelector:@selector(requestData) withObject:nil afterDelay:1.0];
}

//获取系统当前时间
-(NSDate *)pullingTableViewRefreshingFinishedDate {
    return [HWTools getSystemNowTime];
    
}

//手指开始拖动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView tableViewDidScroll:scrollView];

}

//手指结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark----------------------- 懒加载
-(PullingRefreshTableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 150) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 250;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;

}

- (NSMutableArray *)dataArray {
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
