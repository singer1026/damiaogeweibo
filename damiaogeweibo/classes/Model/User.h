//
//  User.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-1.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
/*
 idstr	string	字符串型的用户UID
 screen_name	string	用户昵称
 profile_image_url	string	用户头像地址，50×50像素
 
 verified	boolean	是否是微博认证用户，即加V用户，true：是，false：否
 verified_type	int
 */

typedef enum {
    MBTypeNone = 0, // 没有
    MBTypeNormal, // 普通
    MBTypeYear // 年费
} MBType;

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString *idstr; // ID
@property (nonatomic, copy) NSString *screenName; // 用户昵称
@property (nonatomic, copy) NSString *profileImageUrl; // 用户头像

@property (nonatomic, assign) BOOL verified; // 是否是微博认证用户

@property (nonatomic, assign) int verifiedType; // 认证认证

@property (nonatomic, assign) MBType mbtype; // 会员类型
@property (nonatomic, assign) int mbrank; // 会员等级

- (id)initWithDict:(NSDictionary *)dict;
@end
