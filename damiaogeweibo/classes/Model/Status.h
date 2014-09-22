//
//  Status.h
//  weibo
//
//  Created by apple on 13-8-31.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  一条微博
/*
 created_at	string	微博创建时间
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 pic_urls	object	微博配图地址。多图时返回多图链接。无配图返回“[]”
 */

#import "BaseTextModel.h"

@interface Status : BaseTextModel

@property (nonatomic, copy) NSString *source; // 来源
@property (nonatomic, assign) int repostsCount;  // 转发数
@property (nonatomic, assign) int commentsCount;  // 评论数
@property (nonatomic, assign) int attitudesCount;  // 表态数
@property (nonatomic, strong) NSArray *picUrls; // 所有的图片
@property (nonatomic, strong) Status *retweetedStatus; // 被转发的微博

- (void)update:(Status *)other;
@end
