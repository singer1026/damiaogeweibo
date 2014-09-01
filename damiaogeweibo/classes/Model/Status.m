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
@end
