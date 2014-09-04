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
#import "User.h"
#import "MJRefresh.h"
@interface HomeViewController ()
{
    // 所有的微博数据
    NSMutableArray *_statuses;
}
@end

@implementation HomeViewController

-(void) showNewStatusCount:(int)count{
    // 1.创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage stretchImageWithName:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    CGFloat btnWidth = self.view.frame.size.width;
    CGFloat btnHeight = 44;
    if (ios_version>=7.0) {
        btn.frame = CGRectMake(0, 20, btnWidth, btnHeight);
    }else if(ios_version < 7.0){
        btn.frame = CGRectMake(0, 0, btnWidth, btnHeight);
    }
    
    // 添加按钮到导航栏后面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置文字
    NSString *text = @"没有新的微博";
    if (count) {
        text = [NSString stringWithFormat:@"共有%d条微博", count];
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    
    // 3.执行动画
    [UIView animateWithDuration:0.3 animations:^{
        // 往下挪
        btn.transform = CGAffineTransformMakeTranslation(0, btnHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            // 往回挪
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

-(void) loadStatusDataWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = @"正在加载数据……";
    [StatusTool statusesWithSinceId:sinceId maxId:maxId success:^(NSMutableArray *statuses) {
        if (sinceId == nil && maxId == nil) {
            //第一次进入加载数据
            _statuses=statuses;
            //显示刷新了多少条微博
            [self showNewStatusCount:statuses.count];
        }else if(maxId != nil && sinceId == nil){
            //上拉加载更多
           [_statuses addObjectsFromArray:statuses];
        }else{
            //下拉刷新
            //显示刷新了多少条微博
            [self showNewStatusCount:statuses.count];
            [statuses addObjectsFromArray:_statuses];
            _statuses=statuses;
        }
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } fail:^{
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}

-(void) headerRereshing{
    //加载ID>sinceId的微博
    NSString *sinceId = nil;
    if (_statuses.count) { // 取出最前面那条微博的id
        Status *first = _statuses[0];
        sinceId = first.idstr;
    }
    [self loadStatusDataWithSinceId:sinceId maxId:nil];

}

-(void)footerRereshing{
    if (_statuses.count) {
        Status *lastStatus = _statuses.lastObject;
        NSString *maxId = lastStatus.idstr;
        long long lastMaxid = [maxId longLongValue];
        lastMaxid--;
        [self loadStatusDataWithSinceId:nil maxId:[NSString stringWithFormat:@"%lld",lastMaxid]];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.title = [AccountTool sharedAccountTool].currentAccount.screenName;
    
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithIcon:@"navigationbar_compose.png" target:self actioin:@selector(showSendWeibo)];
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithIcon:@"navigationbar_pop.png" target:self actioin:@selector(popMenu)];
    
    //请求微博列表数据
//    NSString *urlstr = @"https://api.weibo.com/2/statuses/home_timeline.json";
//    NSURL *url = [NSURL URLWithString:urlstr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _statuses = [NSMutableArray array];

    [self.tableView headerBeginRefreshing];
    
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    
    Status *s  = _statuses[indexPath.row];
    //覆盖数据
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:s.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default.png"] options:SDWebImageLowPriority | SDWebImageRefreshCached | SDWebImageRetryFailed];
    [cell.textLabel setText:s.text];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Status *s = _statuses[indexPath.row];
    CGSize textSize = [s.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(250, MAXFLOAT)];
    return textSize.height + 50;
}

@end
