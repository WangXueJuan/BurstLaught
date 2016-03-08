//
//  RegisterViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "RegisterViewController.h"
#import "ProgressHUD.h"
#import <BmobSDK/Bmob.h>
#import "LoginViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *againPassField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UISwitch *switchP;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.passwordField.secureTextEntry = YES;
    self.againPassField.secureTextEntry = YES;
    
    self.switchP.on = NO;
    
}

- (IBAction)switchAction:(id)sender {
    UISwitch *passSwitch = sender;
    if (passSwitch.on) {
        self.passwordField.secureTextEntry = NO;
        self.againPassField.secureTextEntry = NO;
    } else {
        self.passwordField.secureTextEntry = YES;
        self.againPassField.secureTextEntry = YES;
    }
    
}

- (IBAction)registerUserAction:(id)sender {
    if (![self checkOut]) {
        return;
    }
    [ProgressHUD show:@"正在为您注册...."];
    BmobUser *bmUser = [[BmobUser alloc] init];
    [bmUser setUsername:self.userField.text];
    [bmUser setPassword:self.passwordField.text];
    [bmUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [ProgressHUD showSuccess:@"注册成功"];
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController popToViewController:loginVC animated:YES];
        } else {
            [ProgressHUD showSuccess:@"注册失败"];
        }
    }];
    
    
}

//注册之前需要判断
- (BOOL)checkOut {
   
    //用户名不能为空
    if (self.userField.text.length <= 0 || [self.userField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:@"用户名有空格或格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *alertSure = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:alertAction];
        [alert addAction:alertSure];
        //添加提示框
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    //两次输入密码一致
    if (![self.passwordField.text isEqualToString:self.againPassField.text]) {
        //提示框
        UIAlertController *alertPass = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *alertSu = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertPass addAction:alertAction];
        [alertPass addAction:alertSu];
        [self presentViewController:alertPass animated:YES completion:nil];
        return NO;
    }
    //输入密码不能为空
    if ([self.passwordField.text isEqualToString:@" " ]|| [self.passwordField.text isEqualToString:@" "]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能为空，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *alertCan = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:alertAction];
        [alert addAction:alertCan];
        [self presentViewController:alert animated:YES completion:nil];
    }
    return YES;
}


//点击return处回收键盘
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
