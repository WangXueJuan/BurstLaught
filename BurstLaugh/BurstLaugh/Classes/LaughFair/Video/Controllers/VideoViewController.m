//
//  VideoViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "VideoViewController.h"
#import "PullingRefreshTableView.h"
#import "VideoTableViewCell.h"
#import "AFNetworking.h"
#import "videoModel.h"
#import "HWTools.h"
#import <AVFoundation/AVFoundation.h>
#import "videoFrame.h"

@interface VideoViewController ()<UITableViewDataSource, UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    NSInteger _pageCount;
    NSString *_netId;
    CGFloat cellHeight;
}


@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *videoArray;
@property (nonatomic, assign) BOOL refreshing;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    //启动自动刷新
    [self.tableView launchRefreshing];
    //请求网络数据
    [self loadDataRe];
    
}


//请求网络数据
- (void)loadDataRe {
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    [sessionManger GET:[NSString stringWithFormat:@"%@udid=%@",kVideoList, _netId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //下拉刷新时需要移除数组中的数据
        if (self.refreshing) {
            if (self.videoArray.count > 0) {
                [self.videoArray removeLastObject];
            }
        }
        NSDictionary *responDic = responseObject;
        NSMutableArray *listArray = responDic[@"list"];
        NSMutableArray *array = [NSMutableArray new];
        for (NSDictionary *dic in listArray) {
            videoModel *model = [[videoModel alloc] initWithDictionary:dic];
            [array addObject:model];
            [self.videoArray addObject:array];
        }
        //完成加载
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd = NO;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

#pragma mark --------------------------- UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *array = self.videoArray[indexPath.section];
    videoModel *model = array[indexPath.row];
    cell.videoModel = model;
    return cell;


}

//返回分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoArray.count;
}

//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = self.videoArray[indexPath.section];
    videoModel *model = array[indexPath.row];
     cellHeight = [VideoTableViewCell getCellHeightModel:model];
    return cellHeight + 50;
    
}


#pragma mark ------------------ 监听播放器






//下拉刷新
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {
    _pageCount = 1;
    self.refreshing = YES;
    [self performSelector:@selector(loadDataRe) withObject:nil afterDelay:1.0];

    
}

//上拉加载
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
    _pageCount += 1;
    self.refreshing = NO;
    [self performSelector:@selector(loadDataRe) withObject:nil afterDelay:1.0];
    
}
//刷新完成时间
-(NSDate *)pullingTableViewRefreshingFinishedDate {
    return [HWTools getSystemNowTime];
}


#pragma mark ----------------------- 懒加载
-(PullingRefreshTableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 150) pullingDelegate:self];
        self.tableView.rowHeight = 270;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
    
}


-(NSMutableArray *)videoArray {
    if (!_videoArray) {
        self.videoArray = [NSMutableArray new];
    }
    return _videoArray;

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
