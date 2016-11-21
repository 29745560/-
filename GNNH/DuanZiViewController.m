//
//  DuanZiViewController.m
//  GNNH
//
//  Created by WYS on 16/8/31.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "DuanZiViewController.h"
#import "DetailViewController.h"

static NSString * Identifier = @"DzCell";

@interface DuanZiViewController ()<UITableViewDataSource,UITableViewDelegate,ContentCellDelegate,UIActionSheetDelegate>

@property (nonatomic,strong) UITableView * dzTableView;

@end

@implementation DuanZiViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dzTableView = [[UITableView alloc]initWithFrame:SetScreenBounds style:UITableViewStyleGrouped];
    [self.dzTableView setDelegate:self];
    [self.dzTableView setDataSource:self];
    [self.dzTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.dzTableView setSeparatorColor:[UIColor whiteColor]];
    [self.view addSubview:self.dzTableView];
    
    
    

}

#pragma mark - UITableView delagate datasource
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
    CGRect textRect = [Tool getTextRect:@"我呵呵空间哦窘迫和我你那么" textFont:14 textWidth:MainWidth-10];
    
    CGFloat height = 5+30+5+textRect.size.height+10+5+5+20+5;
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier typeIndex:DzType infoNSDictionary:nil];
    }
    
    cell.delegate = self;

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * vc = [[DetailViewController alloc]initWithType:DzType];
    GoToNextVC
}

#pragma mark - ContentCell  Delegate
-(void)contentButtonClick:(NSInteger)clickType contentCell:(ContentCell *)cell
{
    //NSInteger section = [[self.dzTableView indexPathForCell:cell] section];
    
    switch (clickType)
    {
        case PersonClick:
            NSLog(@"个人详情");
            
            break;
            
        case LikeClick:
            NSLog(@"喜欢");
            
            break;
            
        case CollectClick:
            NSLog(@"收藏");
            
            break;
            
        case ShareClick:
            NSLog(@"分享");
            
            break;
            
        case CommentClick:
            NSLog(@"评论");
            
            break;
            
        case ReportClick:
        {
            ShowActionSheect
        }
            break;
    }
}



@end
