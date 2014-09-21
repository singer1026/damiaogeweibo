//
//  StatusCell.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-4.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "StatusCell.h"
#import "StatusOptionBar.h"
#import "BaseFrame.h"

@interface StatusCell ()
{
    StatusOptionBar *_optionBar;
}
@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 3.添加其他
        [self addOtherSubviews];
    }
    return self;
}


#pragma mark 添加其他
- (void)addOtherSubviews
{

    CGFloat y = self.frame.size.height - kStatusOptionBarHeight;
    CGRect frame = CGRectMake(0, y , self.frame.size.width, kStatusOptionBarHeight);
    _optionBar = [[StatusOptionBar alloc] initWithFrame:frame];
    
    
    _optionBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:_optionBar];
    
    //更多
    CGFloat btnWidth =40;
    CGFloat btnHeight =40;
    CGFloat btnX = self.frame.size.width-btnWidth;
    CGFloat btnY = 0;
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [more setImage:[UIImage imageNamed:@"timeline_icon_more.png"] forState:UIControlStateNormal];
    [more setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted.png"] forState:UIControlStateHighlighted];
    more.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    [self.contentView addSubview:more];
}

-(void)unHighlightSubviews:(UIView *)parent{
    NSArray *views = parent.subviews;
    for (UIView *view in views) {
        if ([view respondsToSelector:@selector(setHighlighted:)]) {
            UIButton *btn = (UIButton *)view;
            btn.highlighted = NO;
        }
        [self unHighlightSubviews:view];
    }
}

#pragma mark 覆盖高亮显示的方法
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    // 调用super是为了让cell保持高亮状态
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        [self unHighlightSubviews:self.contentView];
    }
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self unHighlightSubviews:self.contentView];
    }
    
}
- (void)setBaseFrame:(BaseFrame *)baseFrame
{
    [super setBaseFrame:baseFrame];
    
    
    [_optionBar setStatus:self.baseFrame.status];
}



@end
