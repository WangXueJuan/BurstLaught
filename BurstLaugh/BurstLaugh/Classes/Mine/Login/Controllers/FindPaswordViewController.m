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
    
    [self showBackButtonWithImage:@"back"];
    self.passWordTF.secureTextEntry = YES;
    
    self.switchp.on = NO;
    
    
}

//发送短信验证码
- (IBAction)sureNumBtnAction:(id)sender {
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:self.cellPhoneNumberTF.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            //活动smsID
            NSLog(@"sms ID: %d",number);
        }
    }];
    
    
    
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
