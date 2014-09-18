//
//  StatusDetailViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-9-17.
//  Copyright (c) 2014年 Singer. All rights reserved.
//
#define kOptionHeight 44
#import "StatusDetailViewController.h"
#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "StatusDetailCell.h"
#import "StatusDetailCellFrame.h"

@interface StatusDetailViewController ()
{
    StatusDetailCellFrame *_statusDetailCellFrame;
}
@end

@implementation StatusDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"微博正文";
    
    CGSize size = self.view.frame.size;
    _statusDetailCellFrame = [[StatusDetailCellFrame alloc] init];
    _statusDetailCellFrame.status = self.status;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = kGlobalBg;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    tableView.frame = CGRectMake(0, 0, size.width, size.height-kOptionHeight);
    [self.view addSubview:tableView];
    
    
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
    UIView *view  = [[UIView alloc]init];
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 50;
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
