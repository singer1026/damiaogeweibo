//
//  CommentCell.h
//  damiaogeweibo
//
//  Created by Singer on 14-9-22.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCellFrame.h"
@interface CommentCell : UITableViewCell
@property (strong, nonatomic) CommentCellFrame* commentCellFrame;

@property(nonatomic,weak) UITableView *myTableView;
@property (strong, nonatomic) NSIndexPath *indexPaath;
@end
