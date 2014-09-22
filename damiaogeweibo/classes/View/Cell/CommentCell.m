//
//  CommentCell.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-22.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "CommentCell.h"
#import "IconView.h"
#import "Comment.h"
#import "User.h"

@interface CommentCell()
{

    // 1.头像
    IconView *_icon;
    
    // 2.昵称
    UILabel *_screenName;
    
    // 3.会员皇冠图标
    UIImageView *_mbIcon;
    
    // 4.时间
    UILabel *_time;

    
    // 5.正文
    UILabel *_content;
    
    UIImageView *_bg;
    
    UIImageView *_selectedBg;

}

@end


@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        self.backgroundColor =[UIColor clearColor];
        [self setBg];
    }
    return self;
}

-(void)setIndexPaath:(NSIndexPath *)indexPaath{
    _indexPaath = indexPaath;
    
    // 取得这组所有的记录数
    int count = [_myTableView numberOfRowsInSection:indexPaath.section];
    if (indexPaath.row == count-1) {
        //最后一行
        _bg.image = [UIImage stretchImageWithName:@"statusdetail_comment_background_bottom.png"];
        _selectedBg.image = [UIImage stretchImageWithName:@"statusdetail_comment_background_middle_highlighted_bottom.png"];

    }else{
        _bg.image = [UIImage stretchImageWithName:@"statusdetail_comment_background_middle.png"];
        _selectedBg.image = [UIImage stretchImageWithName:@"statusdetail_comment_background_middle_highlighted.png"];
    }
    
}

-(void)setBg{
    //默认的背景
    _bg = [[UIImageView alloc]init];
    self.backgroundView = _bg;
    
    
    //选中的背景
    _selectedBg = [[UIImageView alloc]init];
    self.selectedBackgroundView = _selectedBg;
    
}

-(void)addSubviews{
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
    
    
    // 5.正文
    _content = [[UILabel alloc] init];
    _content.textColor = kContentColor;
    _content.numberOfLines = 0;
    _content.font = kContentFont;
    _content.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_content];
}

-(void)setCommentCellFrame:(CommentCellFrame *)commentCellFrame{
    
    _commentCellFrame = commentCellFrame;
    Comment *comment = commentCellFrame.comment;
    
    // 1.头像
    _icon.frame = _commentCellFrame.icon;
    _icon.user = comment.user;
    
    // 2.昵称
    _screenName.frame = _commentCellFrame.screenName;
    _screenName.text = comment.user.screenName;
    
    if (comment.user.mbtype == MBTypeNone) {
        // 隐藏会员皇冠
        _mbIcon.hidden = YES;
        _screenName.textColor = kScreenNameColor;
    } else {
        // 显示会员皇冠
        _mbIcon.hidden = NO;
        _screenName.textColor = kMBScreenNameColor;
    }
    
    // 3.会员皇冠图标
    _mbIcon.frame = _commentCellFrame.mbIcon;
    
    
    // 4.时间
    _time.frame = commentCellFrame.time;
    _time.text = comment.createdAt;
    
    // 5.正文
    _content.frame = _commentCellFrame.content;
    _content.text = comment.text;
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = kTableBorderWidth;
    frame.size.width -= kTableBorderWidth*2;
    [super setFrame:frame];
}
@end
