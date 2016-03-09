//
//  MineViewController.m
//  BurstLaughing
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "MineViewController.h"
#import "ProgressHUD.h"
#import <SDWebImage/SDImageCache.h>
#import "LoginViewController.h"
#import "CollectionViewController.h"
#import "QiushiViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ShareView.h"
@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *headImageBtn;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong)UILabel *nameLabel;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self.view addSubview:self.tableView];
    self.titleArray = [NSMutableArray arrayWithObjects:@"清除缓存", @"我的收藏",@"用户反馈",@"分享给好友",@"当前版本1.0" ,nil];
    [self setupTableViewHeadImageView];
    [self.view addSubview:self.headImageBtn];
    
}

#pragma mark ----------------- 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //清除缓存
            [self clearImage];
            [ProgressHUD showSuccess:@"已为您清理完毕!"];
            
        }
            break;
        case 1:{
            //我的收藏
            
            
            CollectionViewController *collectVC = [[CollectionViewController alloc] init];
            collectVC.collectModel = self.mineModel;
            
            [self.navigationController pushViewController:collectVC animated:YES];
        }
            break;
        case 2:{
            //用户反馈
            
            [ProgressHUD showSuccess:@"您的反馈信息已发送"];
        }
            break;

        case 3:{
            //分享好友
            [self shareView];
            
        }
            break;

        case 4:{
            //监测版本
            [ProgressHUD show:@"正在为您监测..."];
            [self performSelector:@selector(checkVersion) withObject:nil afterDelay:2.0];
        }
            break;

        default:
            break;
    }

}

//清理缓存
- (void)clearImage {
    SDImageCache *imageChace = [SDImageCache sharedImageCache];
    [imageChace cleanDisk];
    [self.titleArray replaceObjectAtIndex:0 withObject:@"清除缓存"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}

//每次当页面将要重新出现的时候，重新计算图片的缓存
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    SDImageCache *chace = [SDImageCache sharedImageCache];
    NSInteger chaceSize = [chace getSize];
    NSString *cacheStr = [NSString stringWithFormat:@"清除缓存(%.02f)M",(float)chaceSize/1024/1024];
    [self.titleArray replaceObjectAtIndex:0 withObject:cacheStr];
    NSIndexPath *indePath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView  reloadRowsAtIndexPaths:@[indePath] withRowAnimation:UITableViewRowAnimationFade];
    
    
}

//分享好友
- (void)shareView{
     ShareView *shareView = [[ShareView alloc] init];
    [self.view addSubview:shareView];

}

//监测版本
- (void)checkVersion{
    [ProgressHUD showSuccess:@"恭喜您，已是最新版本!"];

}


#pragma mark ------------------- 自定义方法
- (void)setupTableViewHeadImageView{
    UIView *headImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 200)];
    headImageView.backgroundColor = [UIColor grayColor];
    headImageView.alpha = 0.5;
    self.headImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headImageBtn.frame = CGRectMake((kWidth - 160)/2, 80, 160, 160);
    [self.headImageBtn setTitle:@"登陆/注册" forState:UIControlStateNormal];
    [self.headImageBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [self.headImageBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.headImageBtn.backgroundColor = [UIColor whiteColor];
    self.headImageBtn.layer.cornerRadius = 80;
    self.headImageBtn.clipsToBounds = YES;
    [self.headImageBtn addTarget:self action:@selector(loginAndRegister:) forControlEvents:UIControlEventTouchUpInside];

    [headImageView addSubview:self.headImageBtn];
    self.tableView.tableHeaderView = headImageView;

}

//点击登陆注册
-(void)loginAndRegister:(UIButton *)btn {
    UIStoryboard *storBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
   LoginViewController *loginVc = [storBoard instantiateViewControllerWithIdentifier:@"Login"];
    [self.navigationController pushViewController:loginVc animated:YES];
    
    
}


-(UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 110) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 60;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;

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
