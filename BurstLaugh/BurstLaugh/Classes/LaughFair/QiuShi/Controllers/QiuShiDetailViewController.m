//
//  QiuShiDetailViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "QiuShiDetailViewController.h"
#import "PullingRefreshTableView.h"
#import "HWTools.h"
#import "AFNetworking.h"
#import "QiuShiDetailTableViewCell.h"
#import <StoreKit/StoreKit.h>
#import "ProgressHUD.h"
@interface QiuShiDetailViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate, SKStoreProductViewControllerDelegate>
{
   
    NSInteger _pageCount;
    NSInteger count;
    CGFloat cellHeight;
}
@property (nonatomic, strong) UITextField *textFied;
@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UILabel *comentLabel;
@property (nonatomic, strong) UIButton *publishBtn; //发表
@end

@implementation QiuShiDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pageCount = 1;
    [self.view addSubview:self.tableView];
    [self showBackButtonWithImage:@"back"];
    //开始请求网络
    [self rerquestData];
    [self.tableView launchRefreshing];
    //添加右标题
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(kWidth * 0.75, 5, kWidth / 4, 30);
    [commentBtn addTarget:self action:@selector(makeComment:) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:commentBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
}

//开始请求网络
- (void)rerquestData{
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    [sessionManger GET:[NSString stringWithFormat:@"%@/%@/comments?count=50&page=%ld",kQiuShiDetailList, self._detailId, (long)_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ProgressHUD show:@"数据加载完成"];
        NSDictionary *responseDic = responseObject;
        NSMutableArray *itemsArray = responseDic[@"items"];
        for (NSDictionary *dic in itemsArray) {
            QiuShiDetailModell *model = [[QiuShiDetailModell alloc] initWithDictionary:dic];
            [self.listArray addObject:model];
            NSLog(@"%@",model);
        }
        count = self.listArray.count;
        [self.tableView reloadData];
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd = NO;
         [ProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark ---------------------------- 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.listArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

//cell重用机制
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cell = @"cell";
        QiuShiTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:cell];
        if (tableCell == nil) {
            tableCell = [[QiuShiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
        }
        tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableCell.qiushiModel = self.QiushiModel;
        return tableCell;
    }else{
        static NSString *cellId = @"cellId";
        QiuShiDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (detailCell == nil) {
            detailCell = [[QiuShiDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        QiuShiDetailModell *model = self.listArray[indexPath.row];
//        NSLog(@"%@",self.listArray[indexPath.row]);
        detailCell.detailModell = model;
        self.tableView.separatorColor = [UIColor clearColor];
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return detailCell;
    }
}

//添加评论事件
- (void)makeComment:(UIButton *)btn{
    self.textFied = [[UITextField alloc] initWithFrame:CGRectMake(5, kHeight - 300 , kWidth - 10 - 65, 60)];
    self.textFied.borderStyle =UITextBorderStyleRoundedRect;
    self.textFied.placeholder = @"我要评论...";
    [self.view addSubview:self.textFied];
    [self.textFied becomeFirstResponder];
    //发表按钮
    self.publishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.publishBtn.frame = CGRectMake(kWidth - 10 - 65 + 5, kHeight - 300, 60, 60);
    [self.publishBtn setTitle:@"发表" forState:UIControlStateNormal];
    self.publishBtn.layer.cornerRadius = 55 / 4;
    self.publishBtn.clipsToBounds = YES;
    [self.publishBtn addTarget:self action:@selector(publishContext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.publishBtn];
    


}


//发表按钮响应方法
- (void)publishContext{
    if (self.textFied.text) {
        //把输入的内容转化成model类型然后添加到数组中
        QiuShiDetailModell *pingLunModel = [[QiuShiDetailModell alloc] init];
        pingLunModel.content = self.textFied.text;
        [self.listArray insertObject:pingLunModel atIndex:0];
        [self.textFied removeFromSuperview];
        [self.publishBtn removeFromSuperview];
        count += 1;
        
    }
    [self.tableView reloadData];
}

//点击return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textFied resignFirstResponder];
    
    return YES;
}


//上拉加载
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView {
    
}

//下拉刷新
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView {

}

//返回文本高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        cellHeight = [HWTools getTextHeightWithText:self.QiushiModel.content];
        return cellHeight + 80;
    }
    QiuShiDetailModell *model = self.listArray[indexPath.row];
    CGFloat cellH = [HWTools getTextHeightWithText:model.content];
    return cellH + 50;;
    
}

//返回分区高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 40.0;
    }
    return 0;
}

//返回分区标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str = [NSString stringWithFormat:@"%ld条评论",count];
    return str;

}

#pragma mark --------------------------- 懒加载
-(PullingRefreshTableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:self.view.frame pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;

    }
    return _tableView;
}


//获取系统时间
-(NSDate *)pullingTableViewRefreshingFinishedDate {
    return [HWTools getSystemNowTime];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}


-(NSMutableArray *)listArray {
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
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
