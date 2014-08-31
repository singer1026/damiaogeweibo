//
//  NSURLRequest+url.h
//  weibo
//
//  Created by apple on 13-8-31.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Url)

+ (NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params;

@end
