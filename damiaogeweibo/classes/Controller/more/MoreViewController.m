//
//  MoreViewController.m
//  damiaogeweibo
//
//  Created by Singer on 14-8-14.
//  Copyright (c) 2014年 Singer. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
{
    NSArray *_data;
}
@end

@implementation MoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"更多";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    
    //加载more.plist文件的数据
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"more" withExtension:@"plist"];
    
    _data = [NSDictionary dictionaryWithContentsOfURL:url][@"zh_CN"];
    
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:kGlobalBg];
    //iOS7中默认headView会出现一片空白的区域
    if (ios_version>=7.0) {
         self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    }
   
    
    //设置cell之间的间隔
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 5;
    
//    self.automaticallyAdjustsScrollViewInsets =NO;
}

-(void)setting{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_data[section]).count;
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
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.highlightedTextColor = cell.textLabel.textColor;
        
        UIImageView *bg = [[UIImageView alloc] init];
        cell.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        cell.selectedBackgroundView = selectedBg;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    
    //覆盖数据
    NSArray *_subData = _data[indexPath.section];
    NSDictionary *dict = _subData[indexPath.row];
    [cell.textLabel setText:dict[@"name"]];
    
    //设置cell的背景图片
    UIImageView *bg = (UIImageView *)cell.backgroundView;
    UIImageView *selectedBg = (UIImageView *)cell.selectedBackgroundView;
    
    NSString *backageImageName =nil;
    int count  = _subData.count;
    if (count==1) {
       backageImageName = @"common_card_background.png";
    }else if(_subData.count>1){
        if (indexPath.row == 0) {
            backageImageName = @"common_card_top_background.png";
        }else if(indexPath.row == count-1){
            backageImageName = @"common_card_bottom_background.png";
        }else{
            backageImageName = @"common_card_middle_background.png";
        }
    }
    
    
    //一组只有一个
    bg.image = [UIImage stretchImageWithName:backageImageName];
    selectedBg.image = [UIImage stretchImageWithName:[backageImageName filenameAppend:@"_highlighted"]];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
