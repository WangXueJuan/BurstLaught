//
//  JokesViewController.m
//  BurstLaughing
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "JokesViewController.h"
#import "jokerHumorViewController.h"
#import "TextJokerViewController.h"
#import "SCNavTabBarController.h"


@interface JokesViewController ()

@end

@implementation JokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    //添加被管理的子视图控制器
    [self setChildController];
    
}

- (void)setChildController {
    jokerHumorViewController *jokerVC = [[jokerHumorViewController alloc] init];
    jokerVC.title = @"最 新";
    jokerVC.view.backgroundColor = [UIColor whiteColor];
    
    TextJokerViewController *textVc = [[TextJokerViewController alloc] init];
    textVc.title = @"纯 文";
    textVc.view.backgroundColor = [UIColor whiteColor];

    SCNavTabBarController *navTabBar = [[SCNavTabBarController alloc] init];
    navTabBar.subViewControllers = @[jokerVC, textVc];
    navTabBar.showArrowButton = YES;
    [navTabBar addParentController:self];

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
