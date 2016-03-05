//
//  VideoViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "VideoViewController.h"
#import "PullingRefreshTableView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoTableViewCell.h"
#import "AFNetworking.h"
#import "videoModel.h"
#import "HWTools.h"
#import <AVFoundation/AVFoundation.h>


@interface VideoViewController ()<UITableViewDataSource, UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    NSInteger _pageCount;
    NSString *_netId;
}


@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *videoArray;
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
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
    CGFloat cellHeight = [VideoTableViewCell getCellHeightModel:model];
    return cellHeight + 50;
    
}

//cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = self.videoArray[indexPath.section];
    videoModel *video = array[indexPath.row];
    NSLog(@"%@",video.video_url);
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    self.moviePlayer.contentURL = [NSURL URLWithString:video.video_url];
    //添加播放器界面到控制器的view上
    self.moviePlayer.view.frame = CGRectMake(0, 0, kWidth,kWidth - 100);
    [self.tableView addSubview:self.moviePlayer.view];
    //隐藏自动自带的控制面板
    self.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    //添加一个按钮，点击退出播放器
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(20, 20, kWidth - 40, self.moviePlayer.view.frame.size.height - 50);
    [quitBtn addTarget:self action:@selector(removeMovie) forControlEvents:UIControlEventTouchUpInside];
    [self.moviePlayer.view addSubview:quitBtn];
    [self.moviePlayer play];
    
}

#pragma mark ------------------ 监听播放器

- (void)removeMovie{
    [self.moviePlayer.view removeFromSuperview];
}



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

//手指开始拖动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView tableViewDidEndDragging:scrollView];
}

//手指结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark ----------------------- 懒加载
-(PullingRefreshTableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 150) pullingDelegate:self];
        self.tableView.rowHeight = 270;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
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
