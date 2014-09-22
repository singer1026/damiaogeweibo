//
//  CommentCellFrame.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-22.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "CommentCellFrame.h"
#import "IconView.h"
#import "User.h"

@implementation CommentCellFrame

-(void)setComment:(Comment *)comment{
    _comment = comment;
    
    //一个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2*kTableBorderWidth;
    
    /*
     微博本身的子控件
     */
    // 1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    _icon  = (CGRect){{iconX,iconY},[IconView iconViewSizeWithType:IconViewTypeSmall]};
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_icon) + kCellBorderWidth;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [comment.user.screenName sizeWithFont:kScreenNameFont];
    _screenName = (CGRect){ {screenNameX, screenNameY}, screenNameSize};
    
    // 3.会员图标
    CGFloat mbIconX = CGRectGetMaxX(_screenName) + kCellBorderWidth;
    CGFloat mbIconY = CGRectGetMidY(_screenName) - kMBIconHeight * 0.5;
    _mbIcon = CGRectMake(mbIconX, mbIconY, kMBIconWidth, kMBIconHeight);
    
    
    
    // 4.正文
    CGFloat contentX = screenNameX;
    CGFloat contentY = CGRectGetMaxY(_screenName) + kCellBorderWidth;
    CGFloat contentMaxWdith= cellWidth - 2 * kCellBorderWidth - screenNameSize.width;
    CGSize contentSize = [comment.text sizeWithFont:kContentFont constrainedToSize:CGSizeMake(contentMaxWdith, MAXFLOAT)];
    _content = (CGRect){ {contentX, contentY}, contentSize};

    //5. 时间
    CGFloat timeX = contentX;
    CGFloat timeY = CGRectGetMaxY(_content) + kCellBorderWidth;

    //lineHeight 使用这种字体显示出来的文字，一行有多高
    _time = (CGRect){ {timeX, timeY}, 200,kTimeFont.lineHeight};
    
    _cellHeight = CGRectGetMaxY(_time) + kCellBorderWidth;
}

@end
