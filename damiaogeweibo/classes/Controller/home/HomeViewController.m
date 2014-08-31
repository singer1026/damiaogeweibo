//
//  HomeViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-14.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+create.h"
#import "SendWeiboViewController.h"
#import "AccountTool.h"
#import "Account.h"
#import "StatusTool.h"
#import "Status.h"
@interface HomeViewController ()
{
    // 所有的微博数据
    NSMutableArray *_statuses;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [AccountTool sharedAccountTool].currentAccount.screenName;
    
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithIcon:@"navigationbar_compose.png" target:self actioin:@selector(showSendWeibo)];
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop.png" target:self actioin:@selector(popMenu)];
    
    //请求微博列表数据
//    NSString *urlstr = @"https://api.weibo.com/2/statuses/home_timeline.json";
//    NSURL *url = [NSURL URLWithString:urlstr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _statuses = [NSMutableArray array];
    
    [StatusTool statusesWithSinceId:nil maxId:nil success:^(NSMutableArray *statuses) {
        [_statuses addObjectsFromArray:statuses];
        
        [self.tableView reloadData];
    } fail:nil];
}


#pragma mark 显示发微博窗口
-(void) showSendWeibo{
    SendWeiboViewController *sendWebo = [[SendWeiboViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sendWebo];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)popMenu{
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _statuses.count;
}

#pragma mark 每当有一个cell进入屏幕视野范围内就会被调用 返回当前这行显示的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //用static 只会初始化一次
    static NSString *ID = @"UITableViewCell";
    //拿到一个标示符先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果缓存池中没有，才需要传入一个标识创建新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    Status *s  = _statuses[indexPath.row];
    //覆盖数据
    [cell.textLabel setText:s.text];
    return cell;
}

@end
