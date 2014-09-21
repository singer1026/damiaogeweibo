//
//  StatusDetailViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-17.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kOptionHeight 44
#define kTitleViewHeight 50

#import "StatusDetailViewController.h"
#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"
#import "StatusDetailTitileView.h"
#import "StatusTool.h"

@interface StatusDetailViewController ()
{
    StatusDetailCellFrame *_statusDetailCellFrame;
    StatusDetailTitileView *_titileView;
    UITableView *_tableView;
}
@end

@implementation StatusDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"微博正文";
    
    [self createSubviews];
    
    [self loadNewData];
    
}

#pragma mark 加载最新的微博数据
-(void)loadNewData{
    
   [StatusTool statusWithId:_status.idstr success:^(Status *status) {
       _status = status;
       _titileView.status = status;
       
       //修改微博列表的status数据
       _statusDetailCellFrame.status.repostsCount = status.repostsCount;
       _statusDetailCellFrame.status.commentsCount = status.commentsCount;
       _statusDetailCellFrame.status.attitudesCount = status.attitudesCount;
       
       [_tableView reloadData];
   } fail:nil];
}


-(void)createSubviews{
    CGSize size = self.view.frame.size;
    _statusDetailCellFrame = [[StatusDetailCellFrame alloc] init];
    _statusDetailCellFrame.status = self.status;

    _tableView = [[UITableView alloc] init];
    _tableView.allowsSelection = NO;
    
    _tableView.backgroundColor = kGlobalBg;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.frame = CGRectMake(0, 0, size.width, size.height-kOptionHeight);
    [self.view addSubview:_tableView];
    
    
    //评论操作条
    UIImageView *option = [[UIImageView alloc] initWithImage:[UIImage stretchImageWithName:@"toolbar_background.png"]];
    option.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    option.frame = CGRectMake(0, size.height-kOptionHeight, size.width, kOptionHeight);
    [self.view addSubview:option];
}

#pragma mark 每当有一个cell进入屏幕视野范围内就会被调用 返回当前这行显示的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        //微博正文Cell
        static NSString *ID1 = @"StatusCell";
        //拿到一个标示符先去缓存池中查找对应的cell
        StatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        
        //如果缓存池中没有，才需要传入一个标识创建新的cell
        if (cell == nil) {
            cell = [[StatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID1];
        }
        
        
        //覆盖数据
        cell.baseFrame = _statusDetailCellFrame ;
        return cell;

        
    }else{
        //评论，转发Cell
        //用static 只会初始化一次
        static NSString *ID2 = @"UITableViewCell";
        //拿到一个标示符先去缓存池中查找对应的cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        
        //如果缓存池中没有，才需要传入一个标识创建新的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
        }
        
        
        //覆盖数据
        cell.textLabel.text = @"hfsdhfask";
        return cell;
        
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        if (_titileView == nil) {
            CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, kTitleViewHeight);
            _titileView = [[StatusDetailTitileView alloc] initWithFrame:frame];
            _titileView.status = self.status;
        }
        return _titileView;
    }
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return kTitleViewHeight;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return _statusDetailCellFrame.cellHeight;
    }
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 20;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

@end
