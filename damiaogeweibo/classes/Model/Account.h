//
//  Account.h
//  damiaogeweibo
//
//  Created by Singer on 14-8-30.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property (nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *accessToken;
@end
