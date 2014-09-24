//
//  StatusTool.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-31.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kStatusesPath @"statuses/home_timeline.json"
#define kStatusPath @"statuses/show.json"
#define kCommentsPath @"comments/show.json"
#define kRepostsPath @"statuses/repost_timeline.json"
#define kAtStatusesPath @"statuses/mentions.json"

#import "StatusTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "Status.h"
#import "Comment.h"
@implementation StatusTool

+(void)sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *statuses))success fail:(void (^)())fail path:(NSString *)path
{
    sinceId = sinceId==nil?@"0":sinceId;
    maxId = maxId==nil?@"0":maxId;
    
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest
                             requestWithPath:path
                             params:@{ @"since_id" : sinceId, @"max_id" : maxId }];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // 回调
        if (success) {
            // 1.取出所有的微博数据
            NSArray *array = JSON[@"statuses"];
            
            // 2.解析数据为模型(每个dict都代表一条微博)
            NSMutableArray *statuses = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                Status *s = [[Status alloc] initWithDict:dict];
                [statuses addObject:s];
            }
            
            success(statuses);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}


+ (void)statusesWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *statuses))success fail:(void (^)())fail
{
    [self sinceId:sinceId maxId:maxId success:success fail:fail path:kStatusesPath];

}

+(void)statusWithId:(NSString*)idstr success:(void (^)(Status *))success fail:(void (^)())fail{
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest
                             requestWithPath:kStatusPath
                             params:@{ @"id" : idstr}];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (success) {
            Status *status = [[Status alloc]initWithDict:JSON];
            success(status);
        }
       
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}

+(void)commentsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *,int,NSString *))success fail:(void (^)())fail{
    sinceId = sinceId==nil?@"0":sinceId;
    maxId = maxId==nil?@"0":maxId;
    
    
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest
                             requestWithPath:kCommentsPath
                             params:@{ @"since_id" : sinceId, @"max_id" : maxId ,@"id" : idstr}];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        if (success) {
            // 1.取出所有的微博数据
            NSArray *commentArray = JSON[@"comments"];
            NSMutableArray *comments = [NSMutableArray array];
            for (NSDictionary *dict in commentArray) {
                Comment *comment = [[Comment alloc]initWithDict:dict];
                [comments addObject:comment];
            }
            
            success(comments,[JSON[@"total_number"]intValue],[JSON[@"next_cursor"] description]);
        } 
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}


+(void)repostsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *, int, NSString *))success fail:(void (^)())fail{
    sinceId = sinceId==nil?@"0":sinceId;
    maxId = maxId==nil?@"0":maxId;
    
    
    // 创建一个请求对象
    NSURLRequest *request = [NSURLRequest
                             requestWithPath:kRepostsPath
                             params:@{ @"since_id" : sinceId, @"max_id" : maxId ,@"id" : idstr}];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        if (success) {
            // 1.取出所有的微博数据
            NSArray *repostArray = JSON[@"reposts"];
            NSMutableArray *reposts = [NSMutableArray array];
            for (NSDictionary *dict in repostArray) {
                Status *status = [[Status alloc]initWithDict:dict];
                [reposts addObject:status];
            }
            
            success(reposts,[JSON[@"total_number"]intValue],[JSON[@"next_cursor"] description]);
        }
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
    }];
    
    [op start];
}


+(void)atUserStatusesWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *))success fail:(void (^)())fail{
    [self sinceId:sinceId maxId:maxId success:success fail:fail path:kAtStatusesPath];
}
@end
