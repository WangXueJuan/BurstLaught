//
//  AppDelegate.h
//  BurstLaugh
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *wbtoken;
    NSString *webCurrentUserID;

}
@property (nonatomic, strong) NSString *wbtoken;
@property (nonatomic, strong) NSString *webCurrentUserID;
@property (nonatomic, strong) NSString *wbRefreshToken;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarVC;


@end

