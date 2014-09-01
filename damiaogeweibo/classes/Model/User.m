//
//  User.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-1.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "User.h"

@implementation User
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.screenName = dict[@"screen_name"];
        self.profileImageUrl = dict[@"profile_image_url"];
        
        self.verified = [dict[@"verified"] boolValue];
        
        self.verifiedType = [dict[@"verified_type"] intValue];
        
        self.mbtype = [dict[@"mbtype"] intValue];
        self.mbrank = [dict[@"mbrank"] intValue];
    }
    return self;
}
@end
