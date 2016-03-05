//
//  LaughtFairViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "LaughtFairViewController.h"
#import "PrefixHeader.pch"
#import "QiushiViewController.h"
#import "VideoViewController.h"
#import "VerHotViewController.h"
#import "SCNavTabBarController.h"

@interface LaughtFairViewController ()


@end

@implementation LaughtFairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //设置子控制器
    [self setController];
    
}

//设置子控制器
- (void)setController{
    //最热
    VerHotViewController *verHotVC = [[VerHotViewController alloc] init];
    verHotVC.title = @"最 热 笑 料";
    //视频
    VideoViewController *videVC = [[VideoViewController alloc] init];
    videVC.title = @"精 彩 视 频";
    videVC.view.backgroundColor = [UIColor whiteColor];
    
    //糗事
    QiushiViewController *qiushiVc = [[QiushiViewController alloc] init];
    qiushiVc.title = @"幽 默 糗 事";
    qiushiVc.view.backgroundColor = [UIColor whiteColor];
    
    SCNavTabBarController *navTabBar = [[SCNavTabBarController alloc] init];
    navTabBar.subViewControllers = @[verHotVC, videVC, qiushiVc];
    navTabBar.showArrowButton = YES;
    [navTabBar addParentController:self];
    
}


#pragma mark ------------------------- 懒加载


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
