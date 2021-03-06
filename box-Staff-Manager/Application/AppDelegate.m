//
//  AppDelegate.m
//  box-Staff-Manager
//
//  Created by Rony on 2018/2/26.
//  Copyright © 2018年 2se. All rights reserved.
//

#import "AppDelegate.h"
#import "PerfectInformationViewController.h"
#import "HomePageViewController.h"
#import "LoginBoxViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //启动页延时
    //sleep(2);
    [NSThread sleepForTimeInterval:2.0];
    [self getCurrentLanguage];
    //网络监测
    [self monitorReachabilityStatus];
    [self initIQKeyboardManager];
    [self launchJumpVC];
    return YES;
}

-(void)initIQKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager]; //处理键盘遮挡
    //[manager setCanAdjustTextView:YES];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

//保存当前使用语言到NSUserDefaults
-(void)getCurrentLanguage
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        if ([language hasPrefix:@"zh-Hans"]) {//开头匹配
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
        }
    }
}

//启动跳转的VC
-(void)launchJumpVC
{
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = kWhiteColor;
    [self.window makeKeyAndVisible];
    [[BoxDataManager sharedManager] getAllData];
    NSInteger launchState = [[BoxDataManager sharedManager] getLaunchState];
    switch (launchState) {
        case PerfectInformation:
        {
            PerfectInformationViewController *perfectInformationVC = [[PerfectInformationViewController alloc] init];
            UINavigationController *perfectInformationNC = [[UINavigationController alloc] initWithRootViewController:perfectInformationVC];
            //设置导航栏颜色
            [UINavigationBar appearance].barTintColor =  kWhiteColor;
            self.window.rootViewController = perfectInformationNC;
            break;
        }
           
        case EnterHomeBox:
        {
            HomePageViewController *homePageVC = [[HomePageViewController alloc] init];
            self.window.rootViewController = homePageVC;
            break;
        }
        case LoginState:
        {
            LoginBoxViewController *loginVc = [[LoginBoxViewController alloc] init];
            loginVc.fromFunction = FromAppDelegate;
            self.window.rootViewController = loginVc;
            break;
        }
            
        default:
            break;
    }
}


//监测网络状态的方法
- (void)monitorReachabilityStatus
{
    // 开始监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 网络状态改变的回调
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            default:
                break;
        }
    }];
}

#pragma mark ----- 禁止横屏 -----
- (UIInterfaceOrientationMask )application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    //关闭横屏
    return UIInterfaceOrientationMaskPortrait;
    //允许横屏
    //return UIInterfaceOrientationMaskAll;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"startAnimation" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
