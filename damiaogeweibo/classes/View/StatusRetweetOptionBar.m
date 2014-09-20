//
//  StatusRetweetOptionBar.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-20.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kBtnTextColor kGetColor(147,147,147)
#define kBtnTag 99
#import "StatusRetweetOptionBar.h"

@implementation StatusRetweetOptionBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBtnWithTitle:@"转发" icon:@"statusdetail_icon_retweet.png" index:0];
        [self addBtnWithTitle:@"评论" icon:@"statusdetail_icon_comment.png" index:1];
        [self addBtnWithTitle:@"赞" icon:@"statusdetail_icon_like.png" index:2];
    }
    return self;
}

-(void) addBtnWithTitle:(NSString *)title icon:(NSString *)icon index:(int)index{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = self.frame.size;
    CGFloat btnWidth = size.width / 3;
    CGFloat btnX = index * btnWidth;
    
    btn.tag =index+kBtnTag;
    [btn setBackgroundImage:[UIImage stretchImageWithName:@"statusdetail_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(btnX, 0, btnWidth, size.height);
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kBtnTextColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 0, 0);
    [self addSubview:btn];
    
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
        }else if(count % 10000 == 0){
            title  = [NSString stringWithFormat:@"%d万",count/10000];
        }
        else{
            double reslut = (count / 1000.0) * 0.1;
            title  = [NSString stringWithFormat:@"%.1f万",reslut];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
        
    }
}
@end
