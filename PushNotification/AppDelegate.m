//
//  AppDelegate.m
//  PushNotification
//
//  Created by yxhe on 16/10/12.
//  Copyright © 2016年 tashaxing. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // 判断如果是ios8以后，需要用户允许
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound  categories:nil];
        [application registerUserNotificationSettings:notificationSettings];
    }
    
    // 从进程关闭状态收到推送
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"msg"
                                                            message:@"从关闭状态下点击推送横幅打开应用"
                                                           delegate:self
                                                  cancelButtonTitle:@"ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    return YES;
}

// 收到本地推送,点击推送的横幅才会回调
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
    // 此处可以用kvo，kvc，消息等手段更新其他界面的内容,此处发消息带有参数
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLocalPushNotification"
                                                        object:nil
                                                      userInfo:notification.userInfo];
    
    if (application.applicationState == UIApplicationStateActive)
    {
        // 如果应用本来就在前台
        NSLog(@"在前台收到推送");
    }
    else if (application.applicationState == UIApplicationStateInactive)
    {
        // 应用在后台
        NSLog(@"在后台收到推送");
    }
    
    // 更新右上角数字(可以实现点一条推送消息就减少一个，但是好像与打开应用清除所有数字有冲突)
//    badgeNumber = application.applicationIconBadgeNumber;
//    badgeNumber--;
//    badgeNumber = badgeNumber > 0 ? badgeNumber : 0;
//    application.applicationIconBadgeNumber = badgeNumber;
    
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // 应用到前台清除消息数
    badgeNumber = 0;
    application.applicationIconBadgeNumber = badgeNumber;
}



@end
