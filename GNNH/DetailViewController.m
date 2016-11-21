//
//  DetailViewController.m
//  GNNH
//
//  Created by WYS on 16/9/7.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentCell.h"

static NSString * commentID = @"PL_CONTENT";
static NSString * titleID = @"PL_TITLE";

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UIView * backView;
    UITextView * sendTextField;
    int keyHeight;
}
@property (nonatomic,strong) UITableView  * detailTableView;
@property (nonatomic,assign) NSInteger      typeIndex;

@end

@implementation DetailViewController

-(id)initWithType:(NSInteger)clickType
{
    if (self = [super init])
    {
        self.typeIndex = clickType;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.typeIndex == PicType)
    {
        self.title = @"图片详情";
    }
    else if(self.typeIndex == VideoType)
    {
        self.title = @"视频详情";
    }
    else if(self.typeIndex == DzType)
    {
        self.title = @"段子详情";
    }
  
    
    self.detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-40) style:UITableViewStyleGrouped];
    [self.detailTableView setDelegate:self];
    [self.detailTableView setDataSource:self];
    [self.detailTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.detailTableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    [self.view addSubview:self.detailTableView];
    [self.detailTableView registerClass:[CommentCell class] forCellReuseIdentifier:commentID];
    [self.detailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:titleID];
    
    //发布评论视图
    [self initPersonCommentView];
    
    //监听
    [self addKeyObserver];
}

-(void)initPersonCommentView
{
    backView = [UIView new];
    backView.frame = CGRectMake(0, MainHeight-40, MainWidth, 40);
    backView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:backView];


    
    UIButton * sendMessageBtn = [UIButton new];
    [sendMessageBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendMessageBtn addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:sendMessageBtn];
    [sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-5);
        make.width.equalTo(@60);
        make.centerY.equalTo(backView.mas_centerY);
        make.height.equalTo(@30);
    }];
    
    
    
    sendTextField = [UITextView new];
    sendTextField.layer.cornerRadius = 3;
    sendTextField.textColor = [UIColor blackColor];
    sendTextField.font = [UIFont systemFontOfSize:14];
    sendTextField.textAlignment = NSTextAlignmentLeft;
    sendTextField.delegate = self;
    sendTextField.scrollEnabled = NO;
    [backView addSubview:sendTextField];
    [sendTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(5);
        make.top.equalTo(backView.mas_top).offset(5);
        make.bottom.equalTo(backView.mas_bottom).offset(-5);
        make.right.equalTo(sendMessageBtn.mas_left).offset(-5);
    }];
}

-(void)addKeyObserver
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


#pragma mark - UITableview datasource delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
        return 1;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 5+30+5+30+10+5+ MainWidth/2 +5+20+5;
    }
    else
    {
        return 55;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString * vedioCellID = @"VCELLID";
        
        ContentCell * cell = [tableView dequeueReusableCellWithIdentifier:vedioCellID];
        
        if (!cell)
        {
            cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vedioCellID typeIndex:self.typeIndex infoNSDictionary:@{@"viewIndex":@"0"}];
        }
        
        if (self.typeIndex == PicType)
        {
            cell.viewStateIndex = PicState;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    else
    {
        if(indexPath.row == 0)
        {
            UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:titleID forIndexPath:indexPath];
            
            cell.textLabel.text = @"最新评论";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.imageView.image = SetImg(@"CommentBtnIcon");
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
        else
        {
            CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:commentID forIndexPath:indexPath];
            

            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    CGRect rect = [Tool getTextRect:textView.text textFont:14 textWidth:textView.bounds.size.width-10];
    
    CGFloat textHeight = rect.size.height;
    
    if (textHeight < 20)
    {
        textHeight = 0;
    }
    else
    {
        backView.frame = CGRectMake(0, MainHeight-keyHeight-(40+textHeight), MainWidth, 40+textHeight);
    }
}

#pragma mark - button click
-(void)sendMessageClick
{
    sendTextField.text = @"";
    [self.view endEditing:YES];
    NSLog(@"发送");
}

#pragma mark - Notification
//当键盘出现或改变时调用
-(void)keyboardWillShow:(NSNotification *)notification
{
    sendTextField.scrollEnabled = NO;

    NSValue * heightValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    keyHeight = [heightValue CGRectValue].size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
       
        if (sendTextField.text.length !=0)
        {
            [self textViewDidChange:sendTextField];
        }
        else
        {
            backView.frame = CGRectMake(0, MainHeight-keyHeight-40, MainWidth, 40);
        }
    }];
}
//当键退出时调用
-(void)keyboardWillHide:(NSNotification *)notification
{
    sendTextField.scrollEnabled = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        backView.frame = CGRectMake(0, MainHeight-40, MainWidth, 40);
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)SVDisMiss
{
    [SVProgressHUD dismiss];
}

@end