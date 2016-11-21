//
//  PersonalViewController.m
//  GNNH
//
//  Created by WYS on 16/9/8.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "PersonalViewController.h"
#import "DetailViewController.h"
#import "JovisTopTabBar.h"

static NSString * ID1 = @"CELL_1";
static NSString * ID2 = @"CELL_2";
static NSString * Identifier = @"PicCell";


@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,JovisTopTabBarDelegate>

@property (nonatomic,strong) UITableView    * personalTableView;
@property (nonatomic,strong) JovisTopTabBar * selectBar;
@property (nonatomic,strong) UIView         * headerView;
@property (nonatomic,strong) UIButton       * headerImgBtn; //头像
@property (nonatomic,strong) UIButton       * addFocusBtn;     //+关注
@property (nonatomic,strong) UIButton       * TAfansBtn;    //粉丝
@property (nonatomic,strong) UIButton       * TAFocusBtn;   //关注

@end

@implementation PersonalViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = YES;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"用户ID";
    self.personalTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-64) style:UITableViewStyleGrouped];
    [self.personalTableView setDelegate:self];
    [self.personalTableView setDataSource:self];
    [self.personalTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.personalTableView];

    
    [self.personalTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID1];
    [self.personalTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID2];

    
    //设置导航项中的左侧按钮项
    UIBarButtonItem  * refreshItem = [[UIBarButtonItem alloc]initWithTitle:@"举报" style:UIBarButtonItemStyleDone target:self action:@selector(ReportBtnClick)];
    self.navigationItem.rightBarButtonItem = refreshItem;
    
    
    // 设置表头View
    self.headerView = [[UIView alloc]init];
    self.headerView.backgroundColor = [UIColor lightGrayColor];
    self.headerView.frame = CGRectMake(0, 0, MainWidth, 200);
    self.headerView.userInteractionEnabled = YES;
    [self.personalTableView setTableHeaderView:self.headerView];
    
    [self setTableHeaderView];
}

-(void)setTableHeaderView
{
    //头像
    self.headerImgBtn = [UIButton new];
    [self.headerImgBtn setBackgroundColor:[UIColor redColor]];
    [self.headerImgBtn.layer setMasksToBounds:YES];
    [self.headerImgBtn.layer setCornerRadius:50/2];
    [self.headerImgBtn.layer setBorderWidth:0.8];
    [self.headerImgBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.headerImgBtn addTarget:self action:@selector(bigImgSee) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.headerImgBtn];
    [self.headerImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX);
        make.centerY.equalTo(self.headerView.mas_top).offset(50);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    //关注
    self.addFocusBtn = [UIButton new];
    [self.addFocusBtn setBackgroundColor:[UIColor orangeColor]];
    [self.addFocusBtn setTitle:@" + 关 注 " forState:UIControlStateNormal];
    [self.addFocusBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.addFocusBtn.layer setMasksToBounds:YES];
    [self.addFocusBtn.layer setCornerRadius:3];
    [self.addFocusBtn addTarget:self action:@selector(addFocusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.addFocusBtn];
    [self.addFocusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX);
        make.top.equalTo(self.headerImgBtn.mas_bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    //他的粉丝
    self.TAfansBtn = [UIButton new];
    [self.TAfansBtn setBackgroundColor:[UIColor purpleColor]];
    [self.TAfansBtn setTitle:@"粉丝 2160" forState:UIControlStateNormal];
    [self.TAfansBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.TAfansBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.TAfansBtn addTarget:self action:@selector(fansBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.TAfansBtn];
    [self.TAfansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView.mas_left).offset(80);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-30);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];

    //他的关注
    self.TAFocusBtn = [UIButton new];
    [self.TAFocusBtn setBackgroundColor:[UIColor purpleColor]];
    [self.TAFocusBtn setTitle:@"关注 288" forState:UIControlStateNormal];
    [self.TAFocusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.TAFocusBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.TAFocusBtn addTarget:self action:@selector(focusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.TAFocusBtn];
    [self.TAFocusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headerView.mas_right).offset(-80);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-30);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    //线条
    UILabel * label = [UILabel new];
    label.text = @"|";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX);
        make.centerY.equalTo(self.TAfansBtn.mas_centerY);
        make.width.equalTo(@10);
        make.height.equalTo(@20);
    }];
}

#pragma mark - UITableView  DataSource  Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4+1; //网络请求来的数组个数
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
    if (section == 0)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return 50;
        }
        return 30;
    }
    else
    {
        CGSize imageSize = [Tool getImageRect:@" dic[indexPath.section][url] "];
        
        CGRect textRect = [Tool getTextRect:@"我呵呵空间哦窘迫和我你那么" textFont:14 textWidth:MainWidth-10];
        
        CGFloat height = 5+30+5+textRect.size.height+10+5+imageSize.height+5+20+5;
        
        return height;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ID1 forIndexPath:indexPath];
           
            cell.textLabel.text = @"用户签名：安居客不好玩被举报了那个我艾尔干活那累坏了个刘海儿歌";
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else
        {
            UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:ID2 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            
            self.selectBar = [[JovisTopTabBar alloc]initWithFrame:cell.bounds];
            [self.selectBar setBackgroundColor:[UIColor whiteColor]];
            [self.selectBar setTitleArray:[NSMutableArray arrayWithArray:@[@"投稿",@"收藏",@"评论"]]];
            [self.selectBar setDelegate:self];
            [self.selectBar setIndicatorLineHeight:2];
            [self.selectBar setTitleColorForSelected:[UIColor orangeColor]];
            [self.selectBar setIndicatorLineColor:[UIColor orangeColor]];
            [self.selectBar setTitleColorForNormal:[UIColor grayColor]];
            [self.selectBar setTitleFont:[UIFont systemFontOfSize:14]];
            [self.selectBar initializeUI];
            [self.selectBar selectTabWithIndex:0];
            [cell.contentView addSubview:self.selectBar];
            
            return cell;
        }
    }
    else
    {
        ContentCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier typeIndex:PicType infoNSDictionary:nil];
        }
        
        cell.viewStateIndex = PicState;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0)
    {
        DetailViewController * vc = [[DetailViewController alloc]initWithType:PicType];
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - TopBar 点击事件
-(void)topTabBar:(JovisTopTabBar*)topTabBar didSelectTabIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
            NSLog(@"投稿");
            
            break;
        case 1:
            NSLog(@"收藏");
            
            break;
        case 2:
            NSLog(@"评论");
            
            break;
    }
}

#pragma mark - 按钮事件
-(void)ReportBtnClick
{
    NSLog(@"举报");
}

-(void)bigImgSee
{
    NSLog(@"查看大头像");
}

-(void)addFocusBtnClick
{
    NSLog(@"+关注");
}

-(void)fansBtnClick
{
    NSLog(@"他的粉丝");
}

-(void)focusBtnClick
{
    NSLog(@"他的关注");
}

@end
