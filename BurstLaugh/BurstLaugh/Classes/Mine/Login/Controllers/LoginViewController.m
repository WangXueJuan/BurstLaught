//
//  LoginViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/Bmob.h>
#import "VerHotViewController.h"
#import "ProgressHUD.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *forgetPastAction;
@property (weak, nonatomic) IBOutlet UIButton *loginAction;


@end

@implementation LoginViewController

//点击登录
- (IBAction)loginAction:(id)sender {
    [BmobUser loginWithUsernameInBackground:self.userTextField.text password:self.passwordTextField.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            [ProgressHUD showSuccess:@"登陆成功!"];
            VerHotViewController *verVc = [[VerHotViewController alloc] init];
            [self.navigationController popToViewController:verVc animated:YES];
            NSLog(@"user = %@",user);
        }
    }];
}


//点击空白处回收键盘
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//点击return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

//点击忘记密码
- (IBAction)forgetPasswordAction:(id)sender {
}


//点击注册
- (IBAction)registerAction:(id)sender {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
