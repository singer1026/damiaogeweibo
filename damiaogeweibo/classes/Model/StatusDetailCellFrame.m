//
//  StatusDetailCellFrame.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-18.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "StatusDetailCellFrame.h"
#import "Status.h"
@implementation StatusDetailCellFrame
-(void)setStatus:(Status *)status{
    [super setStatus:status];
    if (self.status.retweetedStatus) {
        _retweet.size.height+=kStatusOptionBarHeight;
        _cellHeight += kStatusOptionBarHeight;
    }
}
@end
