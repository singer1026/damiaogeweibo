//
//  ViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"ViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];

}

- (IBAction)loadData:(id)sender {
    NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
    NSString *accessToken =[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&access_token=%@",userID,accessToken];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"用户信息:\n%@",dictData);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加载错误%@",error);
    }];
    [operation start];
    
}

- (IBAction)sendWeibo:(id)sender {
    NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
    NSString *accessToken =[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/update.json"];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSMutableData *postBody = [NSMutableData data];
    NSString *content =@"哈哈哈 biu biu 发微博啦！ 测试";
    [postBody appendData:[[NSString stringWithFormat:@"uid=%@&access_token=%@&status=%@",userID,accessToken,content] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"发微博:\n%@",dictData);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送失败%@",error);
    }];
    [operation start];

}
@end
