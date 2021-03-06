//
//  ShareView.m
//  BurstLaugh
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "ShareView.h"
#import "AppDelegate.h"
#import "WeiboSDK.h"

@interface ShareView ()
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) UIView *blackView;


@end

@implementation ShareView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configView];
    }
    return self;
}

//显示的四个按钮和label
- (void)configView {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    //初始化切换图
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.blackView.alpha = 0.0;
    self.blackView.backgroundColor = [UIColor blackColor];
    [window addSubview:self.blackView];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 200, kWidth, 200)];
    self.shareView.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.shareView];
    //新浪微博
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(10, 20, kWidth/4, kWidth/4);
    [weiboBtn setImage:[UIImage imageNamed:@"sina_weibo"] forState:UIControlStateNormal];
    weiboBtn.tag = 1;
    [weiboBtn addTarget:self action:@selector(sharBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kWidth /4 + 20, kWidth/4, 30)];
    weiboLabel.text = @"新浪微博";
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:weiboBtn];
    [self.shareView addSubview:weiboLabel];
    //朋友圈
    UIButton *friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friendBtn.frame = CGRectMake(kWidth/3 + 10, 20, kWidth / 4, kWidth / 4);
    [friendBtn setImage:[UIImage imageNamed:@"py_normal-1"] forState:UIControlStateNormal];
    [friendBtn addTarget:self action:@selector(sharBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    friendBtn.tag = 2;
    [self.shareView addSubview:friendBtn];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 3 + 10, kWidth /4 + 20, kWidth / 4, 30)];
    label2.text = @"朋友圈";
    label2.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:label2];
    //微信
    UIButton *weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weixinBtn.frame = CGRectMake(kWidth * 2 / 3, 20, kWidth / 4, kWidth / 4);
    [weixinBtn setImage:[UIImage imageNamed:@"icon_pay_weixin"] forState:UIControlStateNormal];
    weixinBtn.tag = 3;
    [weixinBtn addTarget:self action:@selector(sharBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:weixinBtn];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(kWidth * 2 / 3 + 10, kWidth / 4 + 20, kWidth / 4, 30)];
    label3.text = @"微 信";
    label3.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:label3];
    //remove
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.frame = CGRectMake(20, kWidth * 3 / 8 + 10, kWidth - 40, 30);
    [removeBtn setTitle:@"取消" forState:UIControlStateNormal];
    removeBtn.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:129.0 / 255.0 blue:169.0 / 255.0 alpha:1.0];
    [removeBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:removeBtn];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.blackView.alpha = 0.8;
        self.shareView.frame = CGRectMake(0, kHeight - 200, kWidth, 200);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.blackView.alpha = 0.8;
        }];
    }];
    
}


//点击分享按钮
- (void)sharBtnAction:(UIButton *)btn {
    switch (btn.tag) {
        case 1:{
            //新浪微博分享
            AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
            WBAuthorizeRequest *authRequest =[WBAuthorizeRequest request];
            authRequest.redirectURI = kRedirectURL;
            authRequest.scope = @"all";
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
            [WeiboSDK sendRequest:request];            request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
            [WeiboSDK sendRequest:request];
            
            [self.blackView removeFromSuperview];
            [self.shareView removeFromSuperview];
            
            
        }
            break;
        case 2: {
            //朋友圈
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text = @"爆笑BreakOut，这是我的一个测试软件，最新视频，图片，段子爆笑分享，让你笑个不停，下载地址https://itunes.apple.com/cn/genre/yin-le/id34";
            req.bText = YES;
            //发送场景 为 微信朋友圈 默认为 会话窗口
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
            [self alertViewAction];
        
        }
            break;
        case 3: {
            //微信朋友
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text = @"爆笑BreakOut，这是我的一个测试软件，最新视频，图片，段子爆笑分享，让你笑个不停，下载地址https://itunes.apple.com/cn/genre/yin-le/id34";
            req.bText = YES;
            //发送场景 为 微信朋友圈 默认为 会话窗口
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
            [self alertViewAction];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)alertViewAction {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:@"恭喜您" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

}

//点击取消按钮，移除这个视图
- (void)cancelAction{
    [UIView animateWithDuration:1.0 animations:^{
        self.blackView.alpha = 0.0;
        self.shareView.alpha = 0.0;
    }];
    [self.shareView removeFromSuperview];
    [self.blackView removeFromSuperview];
    


}

- (WBMessageObject *)messageToShare{
    WBMessageObject *message = [WBMessageObject message];
    message.text = NSLocalizedString(@"这是我的一个测试软件，爆笑BreakOut,最新爆料段子，视频，图片，让你笑个不停...", nil);
    WBImageObject *image = [WBImageObject object];
    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon-60" ofType:@".png"]];
    message.imageObject = image;
    
    return message;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
