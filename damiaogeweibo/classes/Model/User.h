//
//  User.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-1.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
typedef enum {
    VerifiedTypeNone = -1,
    VerifiedTypePersonal = 0,
    VerifiedTypeOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    VerifiedTypeOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    VerifiedTypeOrgWebsite = 5, // 网站官方：猫扑
    VerifiedTypeDaren = 220
} VerifiedType;


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
