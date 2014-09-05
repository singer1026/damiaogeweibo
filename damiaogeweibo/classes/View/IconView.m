//
//  IconView.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-5.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "IconView.h"
#import "User.h"
@interface IconView()
{
    UIImageView *_icon;//头像
    
    UIImageView *_verified;//认证图标
    
    NSString *_placehoder;

}
@end

@implementation IconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       //头像
        _icon = [[UIImageView alloc] init];
        _icon.layer.cornerRadius = 5;
        _icon.layer.masksToBounds = YES;
        [self addSubview:_icon];
        //认证图标
        _verified = [[UIImageView alloc] init];
        _verified.bounds=CGRectMake(0, 0, kVerifiedWidth, kVerifiedHeight);
        [self addSubview:_verified];
        
        self.iconViewType = IconViewTypeSmall;//默认是小图片
    }
    return self;
}

-(void)setUser:(User *)user{
    _user = user;
    //下载头像图片
    [_icon sd_setImageWithURL:[NSURL URLWithString:user.profileImageUrl]  placeholderImage:[UIImage imageNamed:_placehoder]  options:SDWebImageLowPriority | SDWebImageRetryFailed];

    //认证图标
    if (user.verifiedType != VerifiedTypeNone) {
        _verified.hidden = NO;
        
        switch (user.verifiedType) {
             case VerifiedTypeDaren:
                _verified.image = [UIImage imageNamed:@"avatar_grassroot.png"];
                break;
                
            case VerifiedTypePersonal:
                _verified.image = [UIImage imageNamed:@"avatar_vip.png"];
                break;
            default:
                _verified.image = [UIImage imageNamed:@"avatar_enterprise_vip.png"];
                break;
        }
    }else{
        _verified.hidden = YES;
    }
}

-(void)setIconViewType:(IconViewType)iconViewType{
    _iconViewType = iconViewType;
    
    CGFloat iconWidth = 0;
    CGFloat iconHeight = 0;
    switch (_iconViewType) {
        case IconViewTypeBig:
            iconWidth = kIconBigWidth;
            iconHeight = kIconBigHeight;
            _placehoder = @"avatar_default_big.png";
            break;
        
        case IconViewTypeSmall:
            iconWidth = kIconSmallWidth;
            iconHeight = kIconSmallHeight;
            _placehoder = @"avatar_default_small.png";
            break;
        case IconViewTypeDefault:
            iconWidth = kIconWidth;
            iconHeight = kIconHeight;
            _placehoder = @"avatar_default.png";
            break;
    }
    
    //设置控件的位置和尺寸
    self.bounds = CGRectMake(0, 0, iconWidth+kVerifiedWidth*0.5, iconHeight+kVerifiedHeight*0.5);
    _icon.frame = CGRectMake(0, 0, iconWidth, iconHeight);
    _verified.center = CGPointMake(iconWidth, iconHeight);
}

+(CGSize)iconViewSizeWithType:(IconViewType)type{
    CGFloat iconWidth = 0;
    CGFloat iconHeight = 0;
    switch (type) {
        case IconViewTypeBig:
            iconWidth = kIconBigWidth;
            iconHeight = kIconBigHeight;
            
            break;
            
        case IconViewTypeSmall:
            iconWidth = kIconSmallWidth;
            iconHeight = kIconSmallHeight;
            break;
        case IconViewTypeDefault:
            iconWidth = kIconWidth;
            iconHeight = kIconHeight;
            break;
    }
    return CGSizeMake(iconWidth+kVerifiedWidth*0.5, iconHeight+kVerifiedHeight*0.5);
}
@end
