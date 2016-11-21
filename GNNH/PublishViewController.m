//
//  PublishViewController.m
//  GNNH
//
//  Created by WYS on 16/9/9.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "PublishViewController.h"

@interface PublishViewController ()
{
    UIView * backView;
}
@end

@implementation PublishViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"发表";
    self.automaticallyAdjustsScrollViewInsets = false;
    
    UIBarButtonItem * publishItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(publishClick)];
    self.navigationItem.rightBarButtonItem = publishItem;
    
    
    [self addKeyObserver];
    
    [self initView];
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

-(void)initView
{
    //设置键盘
    UIView * keyBoardTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    keyBoardTopView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(keyBoardTopView.bounds.size.width - 60 - 10, 2, 60, 26)];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onKeyBoardDown:) forControlEvents:UIControlEventTouchUpInside];
    [keyBoardTopView addSubview:btn];
    
   
    UITextView * contentText = [UITextView new];
    contentText.font = [UIFont systemFontOfSize:16];
    contentText.inputAccessoryView = keyBoardTopView;
    contentText.scrollEnabled = YES;
    contentText.textAlignment = NSTextAlignmentLeft;
    contentText.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:contentText];
    [contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(64+10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
    }];
    
   
    
    backView = [UIView new];
    backView.frame = CGRectMake(0, MainHeight-50, MainWidth, 50);
    backView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:backView];

    
    
    UILabel * maxNumTextLabel = [UILabel new];
    maxNumTextLabel.textAlignment = NSTextAlignmentRight;
    maxNumTextLabel.font = [UIFont systemFontOfSize:12];
    maxNumTextLabel.text = @"还能输入100个字";
    [backView addSubview:maxNumTextLabel];
    [maxNumTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(10);
        make.right.equalTo(backView.mas_right).offset(-10);
        make.top.equalTo(backView.mas_top);
        make.height.equalTo(@15);
    }];
    
    
    
    UIButton * picBtn = [UIButton new];
    picBtn.backgroundColor = [UIColor whiteColor];
    [picBtn setTitle:@"图片" forState:UIControlStateNormal];
    [picBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backView addSubview:picBtn];
    [picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(10);
        make.top.equalTo(backView.mas_top).offset(20);
        make.bottom.equalTo(backView.mas_bottom).offset(-10);
        make.width.equalTo(@60);
    }];
   
    
    
    UIButton * videoBtn = [UIButton new];
    [videoBtn setTitle:@"视频" forState:UIControlStateNormal];
    [videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    videoBtn.backgroundColor = [UIColor whiteColor];
    [backView addSubview:videoBtn];
    [videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(picBtn.mas_right).offset(10);
        make.top.equalTo(backView.mas_top).offset(20);
        make.bottom.equalTo(backView.mas_bottom).offset(-10);
        make.width.equalTo(@60);
    }];
    

    
    
    UILabel * nmLabel = [UILabel new];
    nmLabel.backgroundColor = [UIColor yellowColor];
    nmLabel.text = @"匿名";
    nmLabel.textAlignment = NSTextAlignmentCenter;
    nmLabel.font = [UIFont systemFontOfSize:14];
    nmLabel.textColor = [UIColor blackColor];
    [backView addSubview:nmLabel];
    [nmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-10);
        make.top.equalTo(backView.mas_top).offset(20);
        make.bottom.equalTo(backView.mas_bottom).offset(-10);
        make.width.equalTo(@40);
    }];
   
    
    
    UIButton * nmBtn = [UIButton new];
    nmBtn.backgroundColor = [UIColor redColor];
    [backView addSubview:nmBtn];
    [nmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nmLabel.mas_left).offset(-10);
        make.top.equalTo(backView.mas_top).offset(25);
        make.bottom.equalTo(backView.mas_bottom).offset(-15);
        make.width.equalTo(@10);
    }];
}


#pragma mark - Notification
//当键盘出现或改变时调用
-(void)keyboardWillShow:(NSNotification *)notification
{
    NSValue * heightValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    int height = [heightValue CGRectValue].size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        backView.frame = CGRectMake(0, MainHeight-height-50, MainWidth, 50);
    }];
}
//当键退出时调用
-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        backView.frame = CGRectMake(0, MainHeight-50, MainWidth, 50);
    }];
}


#pragma mark - 按钮事件
-(void)onKeyBoardDown:(UIButton *)btn
{
    [self.view endEditing:YES];
}

-(void)publishClick
{
    NSLog(@"发表中...");
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end