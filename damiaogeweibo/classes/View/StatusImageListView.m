//
//  StatusImageListView.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-6.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#define kStatusOneImageWidth 120
#define kStatusOneImageHeight 120

#define kStatusImageWidth 80

#define kStatusImageHeight 80

#define kStatusImageMageMargin 10


#import "StatusImageListView.h"
#import "StatusImageView.h"
@implementation StatusImageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i=0; i<9; i++) {
            StatusImageView *imageView = [[StatusImageView alloc]init];
            [self addSubview:imageView];
        }
        
    }
    return self;
}

-(void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    
    int imageCount = _imageUrls.count;
    int subCount =self.subviews.count;
    
    for (int i = 0; i<subCount; i++) {
        StatusImageView *chind = self.subviews[i];
        
        if (i>=imageCount) {
            chind.hidden = YES;
        }else{
            chind.hidden = NO;
            if (imageCount==1) {
                chind.frame = CGRectMake(0, 0, kStatusOneImageWidth, kStatusOneImageHeight);
                chind.contentMode = UIViewContentModeScaleAspectFit;
            }else{
                //列数
                int column = i%3;
                
                //行数
                int row = i/3;
                //计算frame
                int childX = column*(kStatusImageMageMargin+kStatusImageWidth);
                int childY = row*(kStatusImageMageMargin+kStatusImageHeight);
                chind.frame = CGRectMake(childX, childY, kStatusImageWidth, kStatusImageHeight);

                chind.contentMode = UIViewContentModeScaleToFill;
            }
            
            chind.url = _imageUrls[i][@"thumbnail_pic"];
            //设置
        }
    }
}
+(CGSize)imageWithCount:(int)count{
    if (count==1) {
        return  CGSizeMake(kStatusOneImageWidth, kStatusOneImageHeight);
    }
    //行数
    int row = (count+2)/3;

    //计算总高度
    CGFloat height = row * kStatusImageHeight+ (row-1)*kStatusImageMageMargin;
    
    //计算宽度
    int columns = (count>=3) ? 3 : count;
    CGFloat width = columns*kStatusImageWidth+ (columns-1)*kStatusImageMageMargin;
    return CGSizeMake(width, height);
}
@end
