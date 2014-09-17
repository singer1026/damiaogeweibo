//
//  StatusOptionBar.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-9.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kBtnTextColor kGetColor(147,147,147)
#define kBtnTag 99
#import "StatusOptionBar.h"

@implementation StatusOptionBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage stretchImageWithName:@"timeline_card_bottom.png"];
        
        
        //添加分割线
        UIView *topDivider = [[UIView alloc] init];
        topDivider.frame = CGRectMake(0, 0, self.frame.size.width, 1);
        CGFloat topDividerX = 2;
        CGFloat topDividerHeight = 0.7;
        CGFloat topDividerWidth  = self.frame.size.width - 2*topDividerX;
        topDivider.frame = CGRectMake(topDividerX, -topDividerHeight*0.5, topDividerWidth, topDividerHeight);
        
        topDivider.backgroundColor = kGetColor(200, 200, 200);
        
        [self addSubview:topDivider];
        
        [self addBtnWithTitle:@"转发" icon:@"timeline_icon_retweet.png" index:0 bg:@"timeline_card_leftbottom.png"];
        [self addBtnWithTitle:@"评论" icon:@"timeline_icon_comment.png" index:1 bg:@"timeline_card_middlebottom.png"];
        [self addBtnWithTitle:@"赞" icon:@"timeline_icon_unlike.png" index:2 bg:@"timeline_card_rightbottom.png"];
       
        
    }
    return self;
}

-(void)setStatus:(Status *)status{
    _status = status;
    
    [self setBtnTitleAtIndex:0 placeholder:@"转发" count:status.repostsCount];
    [self setBtnTitleAtIndex:1 placeholder:@"评论" count:status.commentsCount];
    [self setBtnTitleAtIndex:2 placeholder:@"赞" count:status.attitudesCount];

}

-(void)setBtnTitleAtIndex:(int)index placeholder:(NSString*)placeholder count:(int)count{
    UIButton *btn = (UIButton *)[self viewWithTag:kBtnTag+index];
    
    if (count == 0) {
        [btn setTitle:@"转发" forState:UIControlStateNormal];
    }else{
        NSString *title=nil;
        if (count<10000) {
           title  = [NSString stringWithFormat:@"%d",count];
        }else{
            double reslut = count/ 10000.0;
            title  = [NSString stringWithFormat:@"%.1f万",reslut];
        }
       
        [btn setTitle:title forState:UIControlStateNormal];
        
    }
}

-(void) addBtnWithTitle:(NSString *)title icon:(NSString *)icon index:(int)index bg:(NSString *)bg{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = self.frame.size;
    CGFloat btnWidth = size.width / 3;
    CGFloat btnX = index * btnWidth;
    
    btn.tag =index+kBtnTag;
    [btn setAllStateBg:bg];
    btn.frame = CGRectMake(btnX, 0, btnWidth, size.height);
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kBtnTextColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 0, 0);
    [self addSubview:btn];

    //添加按钮之间的分割线
    if (index > 0) {
        UIImage *image = [UIImage imageNamed:@"timeline_card_bottom_line.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:image];
        divider.center = CGPointMake(btnX, size.height*0.5);
        [self addSubview:divider];
    }
}

@end
