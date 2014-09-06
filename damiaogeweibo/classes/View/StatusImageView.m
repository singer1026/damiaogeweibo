//
//  StatusImageView.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-6.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "StatusImageView.h"

@interface StatusImageView ()
{
    UIImageView *_gifView;
}
@end

@implementation StatusImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        //gif标志
        _gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif.png"]];
        _gifView.hidden =YES;
        [self addSubview:_gifView];
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    _url = url;
 
    [self sd_setImageWithURL:[NSURL URLWithString:_url]  placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder.png"]  options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    //判断是否gif
    if ([url hasSuffix:@"gif"]) {
        _gifView.hidden = NO;
        CGSize size = self.frame.size;
        CGSize gifSzie = _gifView.frame.size;
        _gifView.center = CGPointMake(size.width-gifSzie.width*0.5, size.height-gifSzie.height*0.5);
    }else{
        _gifView.hidden = YES;

    }
}

@end
