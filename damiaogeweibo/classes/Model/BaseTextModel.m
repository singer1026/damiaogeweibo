//
//  BaseTextModel.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-22.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "BaseTextModel.h"
#import "User.h"

@implementation BaseTextModel
- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        
        self.text = dict[@"text"];
        
        
        self.createdAt = dict[@"created_at"];
        
        // 用户
        NSDictionary *userDict =  dict[@"user"];
        if (userDict) {
            self.user = [[User alloc] initWithDict:userDict];
        }
    }
    return self;
}

- (NSString *)createdAt
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [formatter dateFromString:_createdAt];
    
    NSDate *now = [NSDate date];
    
    // 比较微博发送时间和当前时间
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    if (delta < 60) { // 1分钟以内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 60分钟以内
        return [NSString stringWithFormat:@"%.f分钟前", delta / 60];
    } else if (delta < 60 * 60 * 24) { // 24小时内
        return [NSString stringWithFormat:@"%.f小时前", delta / (60 * 60)];
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
}
@end
