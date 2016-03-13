//
//  AppDelegate.m
//  BurstLaugh
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "AppDelegate.h"
#import "LaughtFairViewController.h"
#import "MineViewController.h"
#import "jokerHumorViewController.h"
#import <BmobSDK/Bmob.h>
#import "WeiboSDK.h"
#import "WBHttpRequest+WeiboShare.h"
#import "WBHttpRequest+WeiboToken.h"


@interface AppDelegate ()<WBHttpRequestDelegate, WeiboSDKDelegate>

@end

@implementation AppDelegate
@synthesize webCurrentUserID;
@synthesize wbtoken;
@synthesize wbRefreshToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //注册微博
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    //注册微信
    [WXApi registerApp:kWeiAppKey];
    
    //注册Bmob
    [Bmob registerWithAppKey:kBmobAppkey];
    //初始化UITabBarController
    self.tabBarVC = [[UITabBarController alloc] init];
    //创建被tabBarVC管理的视图控制器
    //笑神
    UIStoryboard *lauStory = [UIStoryboard storyboardWithName:@"Laught" bundle:nil];
    //设置导航栏字体颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:25.0]}];
    UINavigationController *laughNav = lauStory.instantiateInitialViewController;
    //设置图片
    laughNav.tabBarItem.image = [UIImage imageNamed:@"icon_my_enable"];
    laughNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //设置选中图片
    UIImage *lauImage = [UIImage imageNamed:@"ss"];
    laughNav.tabBarItem.selectedImage = [lauImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //段子
    UIStoryboard *jokesStoryBord = [UIStoryboard storyboardWithName:@"jokes" bundle:nil];
    UINavigationController *jokeNav = jokesStoryBord.instantiateInitialViewController;
    //设置图片
    jokeNav.tabBarItem.image = [UIImage imageNamed:@"icon_new_enable"];
    jokeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //设置选中图片
    UIImage *jokeImage = [UIImage imageNamed:@"sy.png"];
    jokeNav.tabBarItem.selectedImage = [jokeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //个人
    UIStoryboard *mineStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *mineNav = mineStoryBoard.instantiateInitialViewController;
    //设置图片
    mineNav.tabBarItem.image = [UIImage imageNamed:@"geren.jpg"];
    mineNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //设置选中图片
    UIImage *mineImage = [UIImage imageNamed:@"geren.jpg"];
    mineNav.tabBarItem.selectedImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //添加被tabBarVC管理的视图
    self.tabBarVC.viewControllers = @[laughNav, jokeNav, mineNav];
    
    //将tabBarVC设为根视图
    self.window.rootViewController = self.tabBarVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark --------------------- 微博
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {

}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"恭喜您，分享成功!", nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.webCurrentUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"返回应用"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:@"返回", nil];
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.webCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        [alert show];
    }
}

//返回请求加载的结果
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSString *title = nil;
    UIAlertView *alert = nil;
    title = @"收到网络回调";
    alert = [[UIAlertView alloc] initWithTitle:title message:[NSString stringWithFormat:@"%@",result] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}


//请求失败
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSString *title = nil;
    UIAlertView *alert = nil;
    title = @"请求异常";
    alert = [[UIAlertView alloc] initWithTitle:title message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [WeiboSDK handleOpenURL:url delegate:self] || [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self] || [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
