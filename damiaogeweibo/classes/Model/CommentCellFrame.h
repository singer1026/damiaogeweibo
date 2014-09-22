//
//  CommentCellFrame.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-22.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"

@interface CommentCellFrame : NSObject
{
    CGFloat _cellHeight;
    
}

@property(nonatomic,strong) Comment *comment;
/*
 cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/*
 微博本身所有子控件的frame
 */
// 1.头像
@property (nonatomic, assign, readonly) CGRect icon;
// 2.昵称
@property (nonatomic, assign, readonly) CGRect screenName;
// 3.会员皇冠图标
@property (nonatomic, assign, readonly) CGRect mbIcon;
// 4.时间
@property (nonatomic, assign, readonly) CGRect time;
// 5.来源
//@property (nonatomic, assign, readonly) CGRect source;
// 6.正文
@property (nonatomic, assign, readonly) CGRect content;
@end
