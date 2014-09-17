//
//  StatusCell.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "IconView.h"
#import "StatusImageListView.h"
#import "StatusOptionBar.h"
@interface StatusCell ()
{
    /*
     微博本身的子控件
     */
    // 1.头像
    IconView *_icon;
    
    // 2.昵称
    UILabel *_screenName;
    
    // 3.会员皇冠图标
    UIImageView *_mbIcon;
    
    // 4.时间
    UILabel *_time;
    
    // 5.来源
    UILabel *_source;
    
    // 6.正文
    UILabel *_content;
    
    // 7.配图
    StatusImageListView *_image;
    
    /*
     被转发微博的子控件
     */
    // 1.被转发微博的整体结构
    UIImageView *_retweet;
    
    // 2.昵称
    UILabel *_retweetScreenName;
    
    // 3.正文
    UILabel *_retweetContent;
    
    // 4.配图
    StatusImageListView *_retweetImage;
    
    StatusOptionBar *_optionBar;
}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 0.设置背景
        [self setBg];
        
        // 1.添加微博本身的子控件
        [self addStatusSubviews];
        
        // 2.添加被转发微博的子控件
        [self addRetweetStatusSubviews];
        
        // 3.添加其他
        [self addOtherSubviews];
    }
    return self;
}

#pragma mark 设置背景
- (void)setBg
{
    // 1.默认背景
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage stretchImageWithName:@"common_card_background.png"];
    self.backgroundView = bg;
    
    // 2.选中背景
    UIImageView *selectedBg = [[UIImageView alloc] init];
    selectedBg.image = [UIImage stretchImageWithName:@"common_card_background_highlighted.png"];
    self.selectedBackgroundView = selectedBg;
}

#pragma mark 添加微博本身的子控件
- (void)addStatusSubviews
{
    // 1.头像
    _icon = [[IconView alloc] init];
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    // 3.会员皇冠图标
    _mbIcon = [[UIImageView alloc] init];
    _mbIcon.image = [UIImage imageNamed:@"common_icon_membership.png"];
    [self.contentView addSubview:_mbIcon];
    
    // 4.时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    _time.textColor = kTimeColor;
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    // 5.来源
    _source = [[UILabel alloc] init];
    _source.textColor = kSourceColor;
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];
    
    // 6.正文
    _content = [[UILabel alloc] init];
    _content.textColor = kContentColor;
    _content.numberOfLines = 0;
    _content.font = kContentFont;
    _content.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_content];
    
    // 7.配图
    _image = [[StatusImageListView alloc] init];
    _image.hidden = YES;
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_image];
}

#pragma mark 添加被转发微博的子控件
- (void)addRetweetStatusSubviews
{
    // 1.被转发微博的整体结构
    _retweet = [[UIImageView alloc] init];
    
    UIImage *retweetImage = [UIImage imageNamed:@"timeline_retweet_background.png"];
    retweetImage = [retweetImage stretchableImageWithLeftCapWidth:retweetImage.size.width * 0.9 topCapHeight:retweetImage.size.height * 0.5];
    _retweet.image = retweetImage;
    [self.contentView addSubview:_retweet];
    
    // 2.昵称
    _retweetScreenName = [[UILabel alloc] init];
    _retweetScreenName.textColor = kRetweetScreenNameColor;
    _retweetScreenName.font = kRetweetScreenNameFont;
    _retweetScreenName.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetScreenName];
    
    // 3.正文
    _retweetContent = [[UILabel alloc] init];
    _retweetContent.textColor = kRetweetContentColor;
    _retweetContent.font = kRetweetContentFont;
    _retweetContent.numberOfLines = 0;
    _retweetContent.backgroundColor = [UIColor clearColor];
    [_retweet addSubview:_retweetContent];
    
    // 4.配图
    _retweetImage = [[StatusImageListView alloc] init];
    _retweetImage.hidden = YES;
    _retweetImage.contentMode = UIViewContentModeScaleAspectFit;
    [_retweet addSubview:_retweetImage];
}

#pragma mark 添加其他
- (void)addOtherSubviews
{

    CGFloat y = self.frame.size.height - kStatusOptionBarHeight;
    CGRect frame = CGRectMake(0, y , self.frame.size.width, kStatusOptionBarHeight);
    _optionBar = [[StatusOptionBar alloc] initWithFrame:frame];
    
    
    _optionBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:_optionBar];
}

- (void)setStatusCellFrame:(StatusCellFrame *)statusCellFrame
{
    _statusCellFrame = statusCellFrame;
    
    Status *status = statusCellFrame.status;
    User *user = status.user;
    
    /*
     微博本身
     */
    // 1.头像
    _icon.frame = statusCellFrame.icon;
    _icon.user = status.user;
    
    // 2.昵称
    _screenName.frame = statusCellFrame.screenName;
    _screenName.text = user.screenName;
    
    if (user.mbtype == MBTypeNone) {
        // 隐藏会员皇冠
        _mbIcon.hidden = YES;
        _screenName.textColor = kScreenNameColor;
    } else {
        // 显示会员皇冠
        _mbIcon.hidden = NO;
        _screenName.textColor = kMBScreenNameColor;
    }
    
    // 3.会员皇冠图标
    _mbIcon.frame = statusCellFrame.mbIcon;
   
    
    // 4.时间
    _time.text = status.createdAt;
    
    // 5.来源
    _source.text = status.source;
    
    /*
     重新计算时间宽度和来源的位置
     */
    // 时间 计算时间宽度
    CGFloat timeX = statusCellFrame.screenName.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusCellFrame.screenName) + kCellBorderWidth*0.5;
    CGSize timeSize = [_time.text sizeWithFont:kTimeFont];
    _time.frame = (CGRect){ {timeX, timeY}, timeSize};
    
    // 来源  计算来源frame
    CGFloat sourceX = CGRectGetMaxX(_time.frame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_source.text sizeWithFont:kSourceFont];
    _source.frame = (CGRect){ {sourceX, sourceY}, sourceSize};
    
    // 6.正文
    _content.frame = statusCellFrame.content;
    _content.text = status.text;
    
    // 7.配图
    _image.frame = statusCellFrame.image;
    if (status.picUrls.count) {
        _image.hidden = NO;
        
        _image.imageUrls = status.picUrls;
    }else{
        _image.hidden = YES;
    }
    
    
    
    /*
     被转发微博
     */
    if (status.retweetedStatus) {
        _retweet.hidden = NO;
        
        // 1.被转发微博的整体结构
        _retweet.frame = statusCellFrame.retweet;
        
        
        // 2.昵称
        _retweetScreenName.frame = statusCellFrame.retweetScreenName;
        _retweetScreenName.text = [NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName];
        
        // 3.正文
        _retweetContent.frame = statusCellFrame.retweetContent;
        _retweetContent.text = status.retweetedStatus.text;
        
        // 4.配图
        _retweetImage.frame = statusCellFrame.retweetImage;
        
        if (status.retweetedStatus.picUrls.count) {
            _retweetImage.imageUrls = status.retweetedStatus.picUrls;
        }
        
    }else{
        _retweet.hidden = YES;
    }
    
    [_optionBar setStatus:self.statusCellFrame.status];
}


#pragma mark 重写setFrame方法
-(void)setFrame:(CGRect)frame{
    frame.origin.x = kTableBorderWidth;
    frame.origin.y += kTableTopBorderWitdh;
    frame.size.width -= kTableBorderWidth*2;
    frame.size.height -=kTableVeiwCellMargin;
    [super setFrame:frame];
}

@end
