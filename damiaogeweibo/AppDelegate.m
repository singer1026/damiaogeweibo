//
//  AppDelegate.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureViewController.h"
#import "MainViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window  = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    NSString *currentVersionCode = [NSBundle mainBundle].infoDictionary[key];
    
    if ([lastVersionCode isEqualToString:currentVersionCode]) {
        //不是第一次使用该版本，不需要加载新版本的开场界面
        [self startWeibo:NO];
    }else{
        //第一次使用该版本号
        //第一次使用后 保存当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionCode forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];//立即写入
        
        NewFeatureViewController *newVC = [[NewFeatureViewController alloc]init];
        newVC.startWeiboBlock = ^(BOOL shared){
            [self startWeibo:shared];
        };
        self.window.rootViewController = newVC ;
        
        
    }

    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)startWeibo:(BOOL)shared{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    self.window.rootViewController = mainVC ;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class]){
        
    }
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
//    NSLog(@"------%@",response.userInfo);
    if ([response isKindOfClass:WBAuthorizeResponse.class]){
        // self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        [[NSUserDefaults standardUserDefaults] setObject:[(WBAuthorizeResponse *)response accessToken] forKey:@"accessToken"];
        [[NSUserDefaults standardUserDefaults] setObject:[(WBAuthorizeResponse *)response userID] forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
