//
//  StatusCellFrame.m
//  weibo
//
//  Created by apple on 13-9-1.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "StatusImageListView.h"
@implementation StatusCellFrame
- (void)setStatus:(Status *)status
{
    _status = status;
    
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    /*
     微博本身的子控件
     */
    // 1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    _icon  = (CGRect){{iconX,iconY},[IconView iconViewSizeWithType:IconViewTypeSmall]};
//    _icon = CGRectMake(iconX, iconY, kIconWidth, kIconHeight);
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_icon) + kCellBorderWidth;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [status.user.screenName sizeWithFont:kScreenNameFont];
    _screenName = (CGRect){ {screenNameX, screenNameY}, screenNameSize};
    
    // 3.会员图标
    CGFloat mbIconX = CGRectGetMaxX(_screenName) + kCellBorderWidth;
    CGFloat mbIconY = CGRectGetMidY(_screenName) - kMBIconHeight * 0.5;
    _mbIcon = CGRectMake(mbIconX, mbIconY, kMBIconWidth, kMBIconHeight);
    
    
    
    // 6.正文
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(_icon) + kCellBorderWidth;
    CGFloat contentMaxWdith = cellWidth - 2 * kCellBorderWidth;
    CGSize contentSize = [status.text sizeWithFont:kContentFont constrainedToSize:CGSizeMake(contentMaxWdith, MAXFLOAT)];
    _content = (CGRect){ {contentX, contentY}, contentSize};
    
    // 7.配图
    if (status.picUrls.count) {
        CGFloat imageX = contentX;
        CGFloat imageY = CGRectGetMaxY(_content) + kCellBorderWidth;
        
        CGSize imageSize = [StatusImageListView imageWithCount:status.picUrls.count];
        _image = (CGRect){{imageX, imageY}, imageSize};
    }
    
    // 8.被转发的微博
    if (status.retweetedStatus) {
        CGFloat retweetX = contentX;
        CGFloat retweetY = CGRectGetMaxY(_content) + kCellBorderWidth;
        CGFloat retweetWidth = cellWidth - 2 * kCellBorderWidth;
        CGFloat retweetHeight = kCellBorderWidth;
        
        // 1.昵称
        CGFloat retweetScreenNameX = kCellBorderWidth;
        CGFloat retweetScreenNameY = kCellBorderWidth;
        NSString *retweetScreenName = [NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName];
        CGSize retweetScreenNameSize = [retweetScreenName sizeWithFont:kRetweetScreenNameFont];
        _retweetScreenName = (CGRect){ {retweetScreenNameX, retweetScreenNameY}, retweetScreenNameSize};
        
        // 2.文本
        CGFloat retweetContentX = retweetScreenNameX;
        CGFloat retweetContentY = CGRectGetMaxY(_retweetScreenName) + kCellBorderWidth;
        CGFloat retweetContentMaxWidth = retweetWidth - 2 * kCellBorderWidth;
        CGSize retweetContentSize = [status.retweetedStatus.text sizeWithFont:kRetweetContentFont constrainedToSize:CGSizeMake(retweetContentMaxWidth, MAXFLOAT)];
        _retweetContent = (CGRect){ {retweetContentX, retweetContentY}, retweetContentSize};
        
        // 3.配图
        if (status.retweetedStatus.picUrls.count) {
            CGFloat retweetImageX = retweetContentX;
            CGFloat retweetImageY = CGRectGetMaxY(_retweetContent) + kCellBorderWidth;

            CGSize retweetSize = [StatusImageListView imageWithCount:status.retweetedStatus.picUrls.count];
            _retweetImage = (CGRect){{retweetImageX, retweetImageY}, retweetSize};
            retweetHeight += CGRectGetMaxY(_retweetImage);

        } else { // 没有配图
            retweetHeight += CGRectGetMaxY(_retweetContent);
        }
        
        // 4.被转发微博总体的高度
       _retweet = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
    }
    
    // 9.总高度
    _cellHeight = kCellBorderWidth;
    if (status.retweetedStatus) { // 有转发
        _cellHeight += CGRectGetMaxY(_retweet);
    } else if (status.picUrls.count) { // 有配图
        _cellHeight += CGRectGetMaxY(_image);
    } else { // 只有文本
        _cellHeight += CGRectGetMaxY(_content);
    }
}
@end
