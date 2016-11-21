//
//  PictureViewController.m
//  GNNH
//
//  Created by WYS on 16/8/31.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "PictureViewController.h"
#import "DetailViewController.h"
#import "PersonalViewController.h"
#import "PublishViewController.h"

static NSString * Identifier = @"PicCell";

@interface PictureViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,ContentCellDelegate>

@property (nonatomic,strong) UITableView   * picTableView;
@property (nonatomic,strong) UIButton      * refreshViewBtn;

@end

@implementation PictureViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.picTableView = [[UITableView alloc]initWithFrame:SetScreenBounds style:UITableViewStyleGrouped];
    [self.picTableView setDelegate:self];
    [self.picTableView setDataSource:self];
    [self.picTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.picTableView setSeparatorColor:[UIColor whiteColor]];
    [self.view addSubview:self.picTableView];

    
    
    /*  发表按钮  */
    UIBarButtonItem * publishItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(publishClick)];
    self.navigationItem.rightBarButtonItem = publishItem;
    
    
    
    /*   刷新图标  */
    _refreshViewBtn = [UIButton new];
    _refreshViewBtn.backgroundColor=[UIColor colorWithWhite:0.9f alpha:0.8f];
    _refreshViewBtn.layer.cornerRadius=5;
    _refreshViewBtn.layer.masksToBounds=YES;
    [_refreshViewBtn setImage:SetImg(@"RefreshIcon") forState:UIControlStateNormal];
    [_refreshViewBtn addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refreshViewBtn];
    [self.view bringSubviewToFront:_refreshViewBtn];
    [_refreshViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    
    
    //上拉刷新
    MJChiBaoZiHeader * header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [self getData];
        [self.picTableView reloadData];
    }];
    [self.picTableView setMj_header:header];
    [header.lastUpdatedTimeLabel setHidden:NO];
    [header setTitle:@"用力向下拉" forState:MJRefreshStateIdle];
    [header setTitle:@"可以松开了" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    
    
    
    //下拉刷新
    self.picTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.picTableView.mj_footer endRefreshing];
    }];
}


#pragma mark - 取得数据
-(void)getData
{
    NSMutableDictionary * paraDic = NSMutableDictionary.new;
    [paraDic setObject:@"1234" forKey:@"uid"];
    [paraDic setObject:@"zhangsan" forKey:@"name"];
    [paraDic setObject:@"no" forKey:@"zan"];
    
    [HTTPManager publicRequest:@"url" parametersDictionary:paraDic completion:^(NSDictionary * dic) {
    
        //dic 是返回的字典，里面包含了获取的信息
        //创建一个全局的字典
        
        if ([dic[@"state"] isEqualToString:@"success"])
        {
            //获取成功
            //[self.picTableView.mj_header endRefreshing];
            //[SVProgressHUD showSuccessWithStatus:@"更新成功！"];
            //[self performSelector:@selector(SVDisMiss) withObject:self afterDelay:1];
        }
    }];
    
    [self.picTableView.mj_header endRefreshing];
    [self.refreshViewBtn setUserInteractionEnabled:YES];
    [self.refreshViewBtn setAlpha:1.0f];

    [SVProgressHUD showSuccessWithStatus:@"更新成功！"];
    [self performSelector:@selector(SVDisMiss) withObject:self afterDelay:1];
}



#pragma mark - UITableView  DataSource  Delegate
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
    CGSize imageSize = [Tool getImageRect:@" dic[indexPath.section][url] "];
    
    CGRect textRect = [Tool getTextRect:@"我呵呵空间哦窘迫和我你那么" textFont:14 textWidth:MainWidth-10];
    
    CGFloat height = 5+30+5+textRect.size.height+10+5+imageSize.height+5+20+5;
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier typeIndex:PicType infoNSDictionary:@{@"viewIndex":@"0"}];
    }

    //数据放在外面，不然刷新会重用
    //布局在里面设置
    
    cell.delegate = self;
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * vc = [[DetailViewController alloc]initWithType:PicType];
    GoToNextVC
}


#pragma mark - ContentCell  Delegate
-(void)contentButtonClick:(NSInteger)clickType contentCell:(ContentCell *)cell
{
    //NSInteger section = [[self.picTableView indexPathForCell:cell] section];
    
    switch (clickType)
    {
        case PersonClick:
        {
            NSLog(@"个人详情");
            PersonalViewController * vc = [[PersonalViewController alloc]init];
            GoToNextVC
        }
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
            
        case PlayVideoClick:
            break;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            NSLog(@"色情");

            break;
        case 1:
            NSLog(@"广告");

            break;
        case 2:
            NSLog(@"版权");

            break;
        case 3:
            NSLog(@"重复");

            break;
    }
}

#pragma mark - 按钮事件
/*  刷新按钮  */
-(void)refreshClick:(UIButton *)button
{
    [button setUserInteractionEnabled:NO];
    [button setAlpha:0.6f];
    
    [self.picTableView.mj_header beginRefreshing];
}

/*  发表内容  */
-(void)publishClick
{
    PublishViewController * vc = [[PublishViewController alloc]init];
    GoToNextVC
}

-(void)SVDisMiss
{
    [SVProgressHUD dismiss];
}

@end
