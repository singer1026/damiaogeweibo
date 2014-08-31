//
//  StatusTool.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-31.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusTool : NSObject
+ (void)statusesWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *))success fail:(void (^)())fail;

@end
