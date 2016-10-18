//
//  ViewController.m
//  PushNotification
//
//  Created by yxhe on 16/10/12.
//  Copyright © 2016年 tashaxing. All rights reserved.
//

// ---- 本地推送和远程推送测试 ---- //

#import "ViewController.h"

NSInteger badgeNumber = 0;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 注册一个消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI:)
                                                 name:@"kLocalPushNotification"
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"kLocalPushNotification"
                                                  object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self]; // 也可以删除全部
}

// 推送消息的更新回调
- (void)updateUI:(NSNotification *)pushUserNotification
{
    self.myLabel.text = pushUserNotification.userInfo[@"text"];
}

// 点击多少次就收到多少条推送
- (IBAction)openBtn:(id)sender
{
    [self registerLocalPushNotification];
}

// 取消推送
- (IBAction)cancelBtn:(id)sender
{
    [self cancelLocalPushNotification];
}

#pragma mark - 注册本地推送通知
- (void)registerLocalPushNotification
{
    // 创建本地通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // 设置推送发出时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    // 设置通知内容
    localNotification.alertBody = @"这是一个推送测试~";
    // 设置通知中心标题
    localNotification.alertTitle = @"推送测试标题";
    // 设置锁屏界面通知文字
    localNotification.alertAction = @"请解锁查看详细";
    // 设置锁屏界面alertaction有效
    localNotification.hasAction = YES;
    // 设置推送音效(可以用系统或者bundle里面自定义的)
    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    localNotification.soundName = @"water.wav"; // 现在需要caf格式文件了
    // 设置应用程序右上角的数字(每次推送更新数字)
    
    localNotification.applicationIconBadgeNumber = ++badgeNumber;
    // 设置推送通知后的信息
    localNotification.userInfo = @{@"text" : [NSString stringWithFormat:@"push %ld", badgeNumber]};
    
    // 调度推送
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

#pragma mark - 取消注册本地推送通知
- (void)cancelLocalPushNotification
{
    // 可以根据参数去取消特定的消息
//    for (UILocalNotification *note in [UIApplication sharedApplication].scheduledLocalNotifications)
//    {
//        [[UIApplication sharedApplication] cancelLocalNotification:note];
//    }
    // 直接取消全部本地通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}


@end
