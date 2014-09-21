//
//  StatusDetailTitileView.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-20.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kBtnWidth 80
#import "StatusDetailTitileView.h"

@interface StatusDetailTitileView ()
{
    UIImageView *_bg;
    UIButton *_selectedBtn;//选中的按钮
    UIImageView *_indicator;
    
    UIButton *_repostBtn;
    UIButton *_commentBtn;
    UIButton *_attiduteBtn;
}

@end

@implementation StatusDetailTitileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kGlobalBg;
        _bg = [[UIImageView alloc]init];
        _bg.userInteractionEnabled = YES;
        _bg.image =[UIImage stretchImageWithName:@"statusdetail_comment_top_background.png"];
        
        CGFloat bgX = kTableBorderWidth;
        CGFloat bgY = 10;
        CGFloat bgWidth =frame.size.width - 2*bgX;
        CGFloat bgHeight = frame.size.height - bgY;
        _bg.frame = CGRectMake(bgX, bgY,bgWidth , bgHeight);
        
        [self addSubview:_bg];
        
        //小三角指示器
        _indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"statusdetail_comment_top_arrow.png"]];
        
        _indicator.center = CGPointMake(100, _bg.frame.size.height - _indicator.frame.size.height*0.5);
        [_bg addSubview:_indicator];
        
        [self addBtns];
        
        //添加分割线
        UIImageView *divider = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"statusdetail_comment_top_rule"];
        divider.image = image;
        divider.center = CGPointMake(kBtnWidth, _bg.frame.size.height*0.5);
        
    }
    return self;
}

-(void)addBtns{
   
    _repostBtn = [self addBtnWithTitle:@"转发" x:0];
    _commentBtn = [self addBtnWithTitle:@"评论" x:kBtnWidth];
    [self btnCilck:_commentBtn];
    
    _attiduteBtn =[self addBtnWithTitle:@"赞" x:_bg.frame.size.width - kBtnWidth];
    _attiduteBtn.userInteractionEnabled = NO;
}

-(UIButton *)addBtnWithTitle:(NSString *)title x:(CGFloat)x{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    //按钮文字颜色
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(x, 0, kBtnWidth, _bg.frame.size.height);
    
    
    [btn addTarget:self action:@selector(btnCilck:) forControlEvents:UIControlEventTouchUpInside];
    [_bg addSubview:btn];
    return btn;
    
}

-(void)setBtnTitleAtIndex:(UIButton *)btn placeholder:(NSString*)placeholder count:(int)count{
  
    if (count == 0) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
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
    
    NSString *title = [btn titleForState:UIControlStateNormal];
    
    [btn setTitle:[title stringByAppendingString:placeholder] forState:UIControlStateNormal];
}


-(void)setStatus:(Status *)status{
    _status = status;
    [self setBtnTitleAtIndex:_repostBtn placeholder:@"转发" count:_status.repostsCount];
    [self setBtnTitleAtIndex:_commentBtn placeholder:@"评论" count:_status.commentsCount];
    [self setBtnTitleAtIndex:_attiduteBtn placeholder:@"赞" count:_status.attitudesCount];
    
    
}
-(void)btnCilck:(UIButton *)btn{
    _selectedBtn.selected = NO;
    btn.selected = YES;
    
    _selectedBtn = btn;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = _indicator.center;
        
        center.x = btn.center.x;
        _indicator.center = center;
    }];
}

@end
