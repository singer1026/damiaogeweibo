//
//  OauthViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-30.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "OauthViewController.h"
#import "Account.h"
#import "AccountTool.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"

@interface OauthViewController ()

@end

@implementation OauthViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5);
    loginBtn.bounds = CGRectMake(0,0, 50, 30);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(showLoginView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

-(void)viewDidAppear:(BOOL)animated{
    [self showLoginView];
}

-(void) showLoginView{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"ViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];

}

-(void)loginWithResponse:(WBBaseResponse *)response{
    NSString *accessToken =[(WBAuthorizeResponse *)response accessToken];
    NSString *uid = [(WBAuthorizeResponse *)response userID];
    if (accessToken !=nil && accessToken.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"accessToken"];
        [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        Account *account  = [[Account alloc] init];
        account.accessToken = accessToken;
        account.uid = uid;
        //发送求获取用户信息
        NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&access_token=%@",uid,accessToken];
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        NSURLRequest *request = [NSURLRequest requestWithPath:@"users/show.json" params:@{kUid:account.uid}];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            MyLog(@"用户信息：%@",JSON);
            account.screenName = JSON[@"screen_name"];
            //归档
            [[AccountTool sharedAccountTool] addAccount:account];
            
            //登录成功进入主界面
            MainViewController *main = [[MainViewController alloc] init];
            self.view.window.rootViewController = main;
            
         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            MyLog(@"获取用户信息失败");
            
        }];
        [operation start];
        
    }else{
        MyLog(@"登录失败");
    }
    
}

@end
