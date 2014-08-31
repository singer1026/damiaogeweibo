//
//  Status.m
//  weibo
//
//  Created by apple on 13-8-31.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Status.h"

@implementation Status
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.source = dict[@"source"];
        self.text = dict[@"text"];
    }
    return self;
}
@end
