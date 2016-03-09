//
//  UIViewController+Common.m
//  HeeHeeWeak
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)


//导航栏添加返回按钮
- (void)showBackButtonWithImage:(NSString *)imageName{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [backBtn addTarget:self action:@selector(backButtonAcyion:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;

}


- (void)backButtonAcyion:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

@end