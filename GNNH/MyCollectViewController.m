//
//  MyCollectViewController.m
//  GNNH
//
//  Created by WYS on 16/9/2.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "MyCollectViewController.h"
#import "JovisTopTabBar.h"

static NSString * Identifier = @"CollectCell";

@interface MyCollectViewController ()<UITableViewDelegate,UITableViewDataSource,JovisTopTabBarDelegate>

@property (nonatomic,strong) UITableView  * myCollectTableView;
@property (nonatomic,strong) JovisTopTabBar * topBar;

@end

@implementation MyCollectViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = false;
    
    
    UIBarButtonItem  * refreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(fefreshClick)];
    self.navigationItem.rightBarButtonItem = refreshItem;

    
    self.myCollectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, MainWidth, MainHeight-30-64) style:UITableViewStyleGrouped];
    [self.myCollectTableView setDataSource:self];
    [self.myCollectTableView setDelegate:self];
    [self.myCollectTableView setSeparatorColor:[UIColor whiteColor]];
    [self.myCollectTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.myCollectTableView];
    
    [_myCollectTableView registerClass:[ContentCell class] forCellReuseIdentifier:Identifier];
    
   
    _topBar = [[JovisTopTabBar alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 30)];
    [_topBar setBackgroundColor:[UIColor whiteColor]];
    [_topBar setTitleArray:[NSMutableArray arrayWithArray:@[@"段子",@"图片",@"视频"]]];
    [_topBar setDelegate:self];
    [_topBar setIndicatorLineHeight:2];
    [_topBar setTitleColorForSelected:[UIColor orangeColor]];
    [_topBar setIndicatorLineColor:[UIColor orangeColor]];
    [_topBar setTitleColorForNormal:[UIColor grayColor]];
    [_topBar setTitleFont:[UIFont systemFontOfSize:14]];
    [_topBar initializeUI];
    [_topBar selectTabWithIndex:0];
    [self.view addSubview:_topBar];
    
}

#pragma mark - tableView dataSource delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10; //网络请求来的数组个数
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 9) //最后一个cell
    {
        return 1;
    }
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - TopBar 点击事件
-(void)topTabBar:(JovisTopTabBar*)topTabBar didSelectTabIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"段子");
            
            break;
        case 1:
            NSLog(@"图片");

            break;
        case 2:
            NSLog(@"视频");

            break;
    }
}

#pragma mark - 刷新
-(void)fefreshClick
{
    NSLog(@"刷新收藏");
}

@end
