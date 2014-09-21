//
//  Status.m
//  weibo
//
//  Created by apple on 13-8-31.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Status.h"
#import "User.h"

@implementation Status
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.source = dict[@"source"];
        self.text = dict[@"text"];
        
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
        
        self.picUrls = dict[@"pic_urls"];
        
        self.createdAt = dict[@"created_at"];
        
        // 被转发的微博
        NSDictionary *retweetDict = dict[@"retweeted_status"];
        if (retweetDict) {
            self.retweetedStatus = [[Status alloc] initWithDict:retweetDict];
        }
        
        // 用户
        NSDictionary *userDict =  dict[@"user"];
        if (userDict) {
            self.user = [[User alloc] initWithDict:userDict];
        }
    }
    return self;
}

- (void)setSource:(NSString *)source
{
    // 解析 <a href="http://app.weibo.com/t/feed/OChwC" rel="nofollow">云中小鸟</a>
    
    int startIndex = [source rangeOfString:@">"].location + 1;
    
    int endIndex = [source rangeOfString:@"</a>"].location;
    
    int len = endIndex - startIndex;
    
    source = [source substringWithRange:NSMakeRange(startIndex, len)];
    
    _source = [NSString stringWithFormat:@"来自%@", source];
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

-(void)update:(Status *)other{
    self.repostsCount = other.repostsCount;
    self.commentsCount = other.commentsCount;
    self.attitudesCount = other.attitudesCount;
    
    self.retweetedStatus.repostsCount = other.retweetedStatus.repostsCount;
    self.retweetedStatus.commentsCount = other.retweetedStatus.commentsCount;
    self.retweetedStatus.attitudesCount = other.retweetedStatus.attitudesCount;

}
@end
