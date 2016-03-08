//
//  FindPaswordViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "FindPaswordViewController.h"
#import "LoginViewController.h"
#import "ProgressHUD.h"

@interface FindPaswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *sureNumberBtn;
@property (weak, nonatomic) IBOutlet UITextField *sureNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation FindPaswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (IBAction)sureNumBtnAction:(id)sender {
    
    
    
}

//点击完成返回到登陆界面
- (IBAction)nextBtnAction:(id)sender {
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    [self.navigationController popToViewController:loginVc animated:YES];
    
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
