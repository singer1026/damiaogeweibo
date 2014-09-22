//
//  StatusTool.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-31.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"

@interface StatusTool : NSObject
/**
 *  加载微博列表
 *
 *  @param sinceId
 *  @param maxId
 *  @param success
 *  @param fail
 */
+ (void)statusesWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *statuses))success fail:(void (^)())fail;


/**
 *  加载单条微博
 *
 *  @param idstr   微博ID
 *  @param success
 *  @param fail
 */
+(void)statusWithId:(NSString*)idstr success:(void (^)(Status *status))success fail:(void (^)())fail;


/**
 *  加载评论列表
 *
 *  @param idstr
 *  @param sinceId
 *  @param maxId
 */
+(void)commentsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *comments))success fail:(void (^)())fail;
@end
