//
//  MessageViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-14.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "MessageViewController.h"
#import "StatusTool.h"
#import "Status.h"
#import "MJRefresh.h"
#import "StatusCellFrame.h"
#import "StatusDetailViewController.h"
#import "StatusCell.h"

@interface MessageViewController ()
{
    // 所有的cellFrame数据
    NSMutableArray *_statusCellFrames;
}
@end

@implementation MessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的微博";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发私信" style:UIBarButtonItemStyleBordered target:self action:@selector(sendPrivateMessage)];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:kGlobalBg];
    
    
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];

    
    
    [StatusTool atUserStatusesWithSinceId:nil maxId:nil success:^(NSMutableArray *statuses) {
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *cellFrame = [[StatusCellFrame alloc] init];
            cellFrame.status = s;
            [newFrames addObject:cellFrame];
        }
        
        _statusCellFrames = newFrames;
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } fail:^{
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}

-(void)sendPrivateMessage{
    
}


-(void)footerRereshing{
    if (_statusCellFrames.count) {
        StatusCellFrame *lastCellFrame = [_statusCellFrames lastObject];
        Status *lastStatus = lastCellFrame.status;
        NSString *maxId = lastStatus.idstr;
        long long lastMaxid = [maxId longLongValue];
        lastMaxid--;
        [self loadStatusDataWithSinceId:nil maxId:[NSString stringWithFormat:@"%lld",lastMaxid]];
    }
}

-(void) loadStatusDataWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId {
    
    [StatusTool statusesWithSinceId:sinceId maxId:maxId success:^(NSMutableArray *statuses) {
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Status *s in statuses) {
            StatusCellFrame *cellFrame = [[StatusCellFrame alloc] init];
            cellFrame.status = s;
            [newFrames addObject:cellFrame];
        }
        
        if (sinceId == nil && maxId == nil) {
            //第一次进入加载数据
            _statusCellFrames = newFrames;
            //显示刷新了多少条微博
            //[self showNewStatusCount:statuses.count];
        }else if(maxId != nil && sinceId == nil){
            //上拉加载更多
            if (newFrames.count>0) {
                [_statusCellFrames addObjectsFromArray:newFrames];
            }
            
        }else if(sinceId != nil && maxId== nil){
            //下拉刷新
            //显示刷新了多少条微博
           // [self showNewStatusCount:statuses.count];
            
            
            // 1.将旧数据添加到新数据的最后面
            [newFrames addObjectsFromArray:_statusCellFrames];
            _statusCellFrames = newFrames;
            
        }
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } fail:^{
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}

#pragma mark - Table view data source
#pragma mark 选择微博跳到微博详情页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusDetailViewController *detail = [[StatusDetailViewController alloc] init];
    StatusCellFrame *scf = _statusCellFrames[indexPath.row];
    detail.status =scf.status;
    [self.navigationController pushViewController:detail animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _statusCellFrames.count;
}

#pragma mark 每当有一个cell进入屏幕视野范围内就会被调用 返回当前这行显示的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.backgroundColor = kGlobalBg;
    }
    
    cell.baseFrame = _statusCellFrames[indexPath.row];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 在这里取出微博数据，计算cell中所有子控件的frame和cell的高度
    StatusCellFrame *frame =_statusCellFrames[indexPath.row];
    return frame.cellHeight;
    
}

@end
