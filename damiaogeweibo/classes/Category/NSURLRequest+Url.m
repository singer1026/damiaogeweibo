//
//  NSURLRequest+url.m
//  weibo
//
//  Created by apple on 13-8-31.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSURLRequest+Url.h"
#import "AccountTool.h"
#import "Account.h"

@implementation NSURLRequest (Url)
+ (NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params
{
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@%@", kBaseURL, path];
    // 拼接参数
    if (params) {
        // 拼接一个?
        [urlStr appendString:@"?"];
        // 拼接accessToken
        [urlStr appendFormat:@"%@=%@", kAccessToken, [AccountTool sharedAccountTool].currentAccount.accessToken];
        // 拼接其他参数
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [urlStr appendFormat:@"&%@=%@", key, obj];
        }];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    return [NSURLRequest requestWithURL:url];
}
@end
