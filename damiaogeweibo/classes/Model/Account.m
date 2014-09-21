//
//  Account.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-30.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "Account.h"

@implementation Account
-(id)initWithCoder:(NSCoder *)decoder{
    
    if (self = [super init]) {
        _accessToken = [decoder decodeObjectForKey:kAccessToken];
        _uid = [decoder decodeObjectForKey:kUid];
        _screenName = [decoder decodeObjectForKey:@"screen_name"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.accessToken forKey:kAccessToken];
    [encoder encodeObject:self.uid forKey:kUid];
    [encoder encodeObject:self.screenName forKey:@"screen_name"];
}
@end
