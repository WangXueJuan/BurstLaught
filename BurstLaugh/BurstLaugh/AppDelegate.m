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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //初始化UITabBarController
    self.tabBarVC = [[UITabBarController alloc] init];
    //创建被tabBarVC管理的视图控制器
    //笑神
    UIStoryboard *lauStory = [UIStoryboard storyboardWithName:@"Laught" bundle:nil];
    UINavigationController *laughNav = lauStory.instantiateInitialViewController;
    //设置图片
    laughNav.tabBarItem.image = [UIImage imageNamed:@"icon_my_enable"];
    laughNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //设置选中图片
    UIImage *lauImage = [UIImage imageNamed:@"icon_my_active"];
    laughNav.tabBarItem.selectedImage = [lauImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //段子
    UIStoryboard *jokesStoryBord = [UIStoryboard storyboardWithName:@"jokes" bundle:nil];
    UINavigationController *jokeNav = jokesStoryBord.instantiateInitialViewController;
    //设置图片
    jokeNav.tabBarItem.image = [UIImage imageNamed:@"icon_top_enable"];
    jokeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //设置选中图片
    UIImage *jokeImage = [UIImage imageNamed:@"icon_top_active"];
    jokeNav.tabBarItem.selectedImage = [jokeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //个人
    UIStoryboard *mineStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *mineNav = mineStoryBoard.instantiateInitialViewController;
    //设置图片
    mineNav.tabBarItem.image = [UIImage imageNamed:@"icon_new_enable"];
    mineNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //设置选中图片
    UIImage *mineImage = [UIImage imageNamed:@"icon_new_active"];
    mineNav.tabBarItem.selectedImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //添加被tabBarVC管理的视图
    self.tabBarVC.viewControllers = @[laughNav, jokeNav, mineNav];
    
    //将tabBarVC设为根视图
    self.window.rootViewController = self.tabBarVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
