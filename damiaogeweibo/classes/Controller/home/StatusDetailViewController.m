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
#import "MJRefresh.h"
#import "BaseTextCellFrame.h"
#import "BaseTextCell.h"

@interface StatusDetailViewController ()
{
    StatusDetailCellFrame *_statusDetailCellFrame;
    StatusDetailTitileView *_titileView;
    UITableView *_tableView;
    
    //所有评论frame数据
    NSMutableArray *_commentCellFrames;
    
    //所有转发frame数据
    NSMutableArray *_repostCellFrames;
    
    //评论数据是否为最后一页
    BOOL _commentLastPage;
    
    //转发数据是否为最后一页
    BOOL _repostLastPage;
}
@end

@implementation StatusDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"微博正文";
    
    
    [self createSubviews];
    
    [self loadNewStatusData];
    
    [self loadNewCommentsData];
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

-(void) headerRereshing{
    if (_titileView.type == TitleViewBtnTypeComment) {
        [self loadNewCommentsData];
    }else if(_titileView.type == TitleViewBtnTypeRepost){
        [self loadNewRepostsData];
    }
}

-(void)footerRereshing{
    if (_titileView.type == TitleViewBtnTypeComment) {
        [self loadMoreComments];
    }else if(_titileView.type == TitleViewBtnTypeRepost){
        [self loadMoreReposts];
    }
    
}

#pragma mark 加载最新的微博数据
-(void)loadNewStatusData{
    
   [StatusTool statusWithId:_status.idstr success:^(Status *status) {
       _status = status;
       _titileView.status = status;
       
       //修改微博列表的status数据
       [_statusDetailCellFrame.status update:status];
       
       [_tableView headerEndRefreshing];
       [_tableView reloadData];
       
   } fail:^{
       [_tableView headerEndRefreshing];
   }];
}

#pragma mark 加载最新的评论列表数据
-(void)loadNewCommentsData{
    
    NSString *sinceId = nil;
    if (_commentCellFrames.count) {
        BaseTextCellFrame *cf = _commentCellFrames[0];
        sinceId = cf.baseTextModel.idstr;
    }
    
    [StatusTool commentsWithId:_status.idstr sinceId:sinceId maxId:nil success:^(NSMutableArray *comments,int totalNum,NSString *nextCursor) {
        if (_commentCellFrames == nil) {
            _commentCellFrames = [NSMutableArray array];
        }
        //计算最新的评论数据的Frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (BaseTextModel *c in comments) {
            BaseTextCellFrame *f = [[BaseTextCellFrame alloc]init];
            f.baseTextModel = c;
            [newFrames addObject:f];
        }
        
        //先将就数据添加到新数据的后面
        [newFrames addObjectsFromArray:_commentCellFrames];
        
        //设置当前所有数据
        _commentCellFrames = newFrames;
        
        //更新微博评论数
        _status.commentsCount = totalNum;
        
        //判断是否有下一页（是否是最后一页），最后一页不加载上拉加载更多
        _commentLastPage = [@"0" isEqualToString:nextCursor];
        
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
        
        
    } fail:^{
        [_tableView headerEndRefreshing];
    }];
}


#pragma mark 上拉加载更多评论
-(void) loadMoreComments{
    
    NSString *maxId = nil;
    if (_commentCellFrames.count) {
        BaseTextCellFrame *cf = [_commentCellFrames lastObject];
        long long lastll = [cf.baseTextModel.idstr longLongValue];
        lastll--;
        maxId = [NSString stringWithFormat:@"%lld",lastll];
    }
    
    [StatusTool commentsWithId:_status.idstr sinceId:nil maxId:maxId success:^(NSMutableArray *comments,int totalNum,NSString *nextCursor) {
        
        //计算最新的评论数据的Frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (BaseTextModel *c in comments) {
            BaseTextCellFrame *f = [[BaseTextCellFrame alloc]init];
            f.baseTextModel = c;
            [newFrames addObject:f];
        }
        
        [_commentCellFrames addObjectsFromArray:newFrames];
        [_tableView footerEndRefreshing];
        //更新微博评论数
        _status.commentsCount = totalNum;
        
        //判断是否有下一页（是否是最后一页），最后一页不加载上拉加载更多
        _commentLastPage= [@"0" isEqualToString:nextCursor];
        
        [_tableView reloadData];
        
        
    } fail:^{
        [_tableView footerEndRefreshing];
    }];
}

-(void)loadNewRepostsData{
    NSString *sinceId = nil;
    if (_repostCellFrames.count) {
        BaseTextCellFrame *cf = _repostCellFrames[0];
        sinceId = cf.baseTextModel.idstr;
    }
    
    [StatusTool repostsWithId:_status.idstr sinceId:sinceId maxId:nil success:^(NSMutableArray *reposts,int totalNum,NSString *nextCursor) {
        if (_repostCellFrames == nil) {
            _repostCellFrames = [NSMutableArray array];
        }
        //计算最新的评论数据的Frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (BaseTextModel *c in reposts) {
            BaseTextCellFrame *f = [[BaseTextCellFrame alloc]init];
            f.baseTextModel = c;
            [newFrames addObject:f];
        }
        
        //先将就数据添加到新数据的后面
        [newFrames addObjectsFromArray:_repostCellFrames];
        
        //设置当前所有数据
        _repostCellFrames = newFrames;
        
        //更新微博评论数
        _status.repostsCount = totalNum;
        
        //判断是否有下一页（是否是最后一页），最后一页不加载上拉加载更多
        _repostLastPage = [@"0" isEqualToString:nextCursor];
        
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
        
        
    } fail:^{
        [_tableView headerEndRefreshing];
    }];
}

#pragma mark 上拉加载更多转发
-(void) loadMoreReposts{
    
    NSString *maxId = nil;
    if (_repostCellFrames.count) {
        BaseTextCellFrame *cf = [_repostCellFrames lastObject];
        long long lastll = [cf.baseTextModel.idstr longLongValue];
        lastll--;
        maxId = [NSString stringWithFormat:@"%lld",lastll];
    }
    
    [StatusTool repostsWithId:_status.idstr sinceId:nil maxId:maxId success:^(NSMutableArray *reposts,int totalNum,NSString *nextCursor) {
        
        //计算最新的评论数据的Frame
        NSMutableArray *newFrames = [NSMutableArray array];
        for (BaseTextModel *c in reposts) {
            BaseTextCellFrame *f = [[BaseTextCellFrame alloc]init];
            f.baseTextModel = c;
            [newFrames addObject:f];
        }
        
        [_repostCellFrames addObjectsFromArray:newFrames];
        [_tableView footerEndRefreshing];
        //更新微博评论数
        _status.repostsCount = totalNum;
        //判断是否有下一页（是否是最后一页），最后一页不加载上拉加载更多
        _repostLastPage = [@"0" isEqualToString:nextCursor];
        
        [_tableView reloadData];
        [_tableView footerEndRefreshing];
        
    } fail:^{
        [_tableView footerEndRefreshing];
    }];
}

-(void)createSubviews{
    CGSize size = self.view.frame.size;
    _statusDetailCellFrame = [[StatusDetailCellFrame alloc] init];
    _statusDetailCellFrame.status = self.status;

    _tableView = [[UITableView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //_tableView.allowsSelection设置为NO，则tableview中所有的cell都不能点了
//    _tableView.allowsSelection = NO;
    
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        static NSString *ID2 = @"BaseTextCell";
        //拿到一个标示符先去缓存池中查找对应的cell
        BaseTextCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        
        //如果缓存池中没有，才需要传入一个标识创建新的cell
        if (cell == nil) {
            cell = [[BaseTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
            cell.myTableView = tableView;
        }
        
         //覆盖数据
        BaseTextCellFrame *cf = nil;
        if (_titileView.type == TitleViewBtnTypeComment) {
            cf = _commentCellFrames[indexPath.row];
        }else if(_titileView.type == TitleViewBtnTypeRepost){
            cf = _repostCellFrames[indexPath.row];
        }
        cell.baseTextCellFrame = cf;
        cell.indexPaath = indexPath;
        return cell;
        
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        if (_titileView == nil) {
            CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, kTitleViewHeight);
            _titileView = [[StatusDetailTitileView alloc] initWithFrame:frame];
            
            __unsafe_unretained StatusDetailViewController *detail = self;
            _titileView.status = self.status;
           
            _titileView.btnClickBlock = ^(TitleViewBtnType type){
                if (type == TitleViewBtnTypeRepost) {
                    //点击转发
                    [detail loadNewRepostsData];
                    
                  }else if (type == TitleViewBtnTypeComment){
                    //点击评论
                    [detail loadNewCommentsData];
                    
                }
                [detail->_tableView reloadData];
            };
        }
        _titileView.status = _status;
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
    }else{
        BaseTextCellFrame *cf =nil;
        if (_titileView.type == TitleViewBtnTypeComment) {
            cf =_commentCellFrames[indexPath.row];
        }else if(_titileView.type == TitleViewBtnTypeRepost){
            cf =_repostCellFrames[indexPath.row];
        }
        
        return cf.cellHeight;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(_titileView.type == TitleViewBtnTypeComment){
        return _commentCellFrames.count;
    }else if(_titileView.type == TitleViewBtnTypeRepost){
        return _repostCellFrames.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //判断上拉下载是否需要显示
    if (_titileView.type == TitleViewBtnTypeComment) {
        _tableView.footerHidden = _commentLastPage;
        
    }else if(_titileView.type == TitleViewBtnTypeRepost){
        _tableView.footerHidden = _repostLastPage;
    }
    return 2;
}

@end
