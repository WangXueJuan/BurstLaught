//
//  LaughtFairViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "LaughtFairViewController.h"
#import "PrefixHeader.pch"
#import "VOSegmentedControl.h"
#import "QiushiViewController.h"
#import "VideoViewController.h"
#import "VerHotViewController.h"

@interface LaughtFairViewController ()
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) VOSegmentedControl *segMentroller;

@end

@implementation LaughtFairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    //导航栏自定义UIView
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 44)];
    self.navigationItem.titleView = self.titleView;
    [self.titleView addSubview:self.segMentroller];
    //设置子控制器
    [self setController];
    
}

//设置子控制器
- (void)setController{
    //最热
    VerHotViewController *verHotVC = [[VerHotViewController alloc] init];
    verHotVC.view.backgroundColor = [UIColor blueColor];
    //视频
    VideoViewController *videVC = [[VideoViewController alloc] init];
    videVC.view.backgroundColor = [UIColor blackColor];
    
    //糗事
    QiushiViewController *qiushiVc = [[QiushiViewController alloc] init];
    qiushiVc.view.backgroundColor = [UIColor grayColor];
    
    
}


#pragma mark ------------------------- 懒加载

//实现segMent
- (VOSegmentedControl *)segMentroller {
    if (!_segMentroller) {
        self.segMentroller = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"最热"}, @{VOSegmentText:@"视频"}, @{VOSegmentText:@"糗事"}]];
        self.segMentroller.contentStyle = VOContentStyleImageAlone;
        self.segMentroller.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segMentroller.backgroundColor = [UIColor clearColor];
        self.segMentroller.selectedBackgroundColor = self.segMentroller.backgroundColor;
        self.segMentroller.allowNoSelection = NO;
        self.segMentroller.frame = CGRectMake(80, 10, kWidth - 120, 30);
        self.segMentroller.indicatorThickness = 3;
        self.segMentroller.selectedSegmentIndex = 0;
        [self.titleView addSubview:self.segMentroller];
        //点击返回的是哪个按钮
        [self.segMentroller addTarget:self action:@selector(segMentControllerAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segMentroller;

}

- (void)segMentControllerAction:(VOSegmentedControl *)segMent{
     if (segMent.selectedSegmentIndex == 1) {
         //最热
         VerHotViewController *verHotVC = [[VerHotViewController alloc] init];
         verHotVC.view.backgroundColor = [UIColor blueColor];
         
         
        
    } else if (segMent.selectedSegmentIndex == 2) {
        
    }
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
