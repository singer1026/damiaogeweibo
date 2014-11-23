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
    
    if (self = [super initWithDict:dict]) {
       
        self.source = dict[@"source"];
        
        self.repostsCount = [dict[@"reposts_count"] intValue];
        self.commentsCount = [dict[@"comments_count"] intValue];
        self.attitudesCount = [dict[@"attitudes_count"] intValue];
        
        self.picUrls = dict[@"pic_urls"];
        
        // 被转发的微博
        NSDictionary *retweetDict = dict[@"retweeted_status"];
        if (retweetDict) {
            self.retweetedStatus = [[Status alloc] initWithDict:retweetDict];
        }
    }
    return self;
}

- (void)setSource:(NSString *)source
{
    if (![@"" isEqualToString:source]) {
        // 解析 <a href="http://app.weibo.com/t/feed/OChwC" rel="nofollow">云中小鸟</a>
        //NSLog(@"---%@",source);
        NSUInteger startIndex = [source rangeOfString:@">"].location + 1;
        
        NSUInteger endIndex = [source rangeOfString:@"</a>"].location;
        
        NSUInteger len = endIndex - startIndex;
        
        source = [source substringWithRange:NSMakeRange(startIndex, len)];
        
        _source = [NSString stringWithFormat:@"来自%@", source];
        //NSLog(@"---%@",_source);
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
