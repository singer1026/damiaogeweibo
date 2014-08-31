//
//  StatusTool.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-31.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kStatusesPath @"statuses/friends_timeline.json"
#import "StatusTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "Status.h"
@implementation StatusTool
+ (void)statusesWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *))success fail:(void (^)())fail
{
    sinceId = sinceId==nil?@"0":sinceId;
    maxId = maxId==nil?@"0":maxId;
    
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest requestWithPath:kStatusesPath params:@{
                                                                                 @"since_id" : sinceId,
                                                                                 @"max_id" : maxId
                                                                                 }];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // 1.取出所有的微博数据
        NSArray *array = JSON[@"statuses"];
        
        // 2.解析数据为模型(每个dict都代表一条微博)
        NSMutableArray *statuses = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            Status *s = [[Status alloc] initWithDict:dict];
            [statuses addObject:s];
        }
        
        // 3.回调
        if (success) {
            success(statuses);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}
@end
