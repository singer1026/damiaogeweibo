//
//  CommentCell.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-22.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextCellFrame.h"
@interface BaseTextCell : UITableViewCell
@property (strong, nonatomic) BaseTextCellFrame* baseTextCellFrame;

@property(nonatomic,weak) UITableView *myTableView;
@property (strong, nonatomic) NSIndexPath *indexPaath;
@end
