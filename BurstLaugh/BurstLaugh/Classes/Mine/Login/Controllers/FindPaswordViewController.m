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
#import <BmobSDK/BmobSMS.h>
#import <BmobSDK/BmobUser.h>
@interface FindPaswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *sureNumberBtn;
@property (weak, nonatomic) IBOutlet UITextField *sureNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@property (weak, nonatomic) IBOutlet UISwitch *switchp;

@end

@implementation FindPaswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self showBackButtonWithImage:@"back"];
    self.passWordTF.secureTextEntry = YES;
    
    self.switchp.on = NO;
    
    
}

//发送短信验证码
- (IBAction)sureNumBtnAction:(id)sender {
    
    if (self.cellPhoneNumberTF.text.length <= 0 && [self.cellPhoneNumberTF.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:@"请输入您的手机号码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *canAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [alert addAction:canAction];
        [self presentViewController:alert animated:YES completion:nil];

    } else {
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.cellPhoneNumberTF.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            //活动smsID
            NSLog(@"sms ID: %d",number);
        }
    }];
  }
}

//点击完成返回到登陆界面
- (IBAction)nextBtnAction:(id)sender {
    //验证短信验证码
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:self.cellPhoneNumberTF.text andSMSCode:self.sureNumberTF.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"验证成功，可执行其他操作");
        } else {
            NSLog(@"验证码出错%@",error);
        }
        
    }];
    
   // 用户收到验证码之后就可以调用resetPasswordBySMSCode方法将密码重置
    [BmobUser resetPasswordInbackgroundWithSMSCode:self.sureNumberTF.text andNewPassword:self.passWordTF.text block:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [ProgressHUD showSuccess:@"密码验证成功，请重新登陆"];
            NSLog(@"密码重置成功");
        } else {
            [ProgressHUD showSuccess:@"密码验证不成功"];
            NSLog(@"密码修改不成功");
           
        }
        
    }];
    
    
    
}

//密码加密
- (IBAction)switchSecurity:(id)sender {
    UISwitch *passSwitch = sender;
    if (passSwitch.on) {
        self.passWordTF.secureTextEntry = NO;
    } else {
        self.passWordTF.secureTextEntry = YES;
       
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
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
