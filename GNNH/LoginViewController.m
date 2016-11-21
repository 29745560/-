//
//  LoginViewController.m
//  GNNH
//
//  Created by WYS on 16/9/5.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property(nonatomic,strong) UIImageView  * headerImage;
@property(nonatomic,strong) UITextField  * textName;
@property(nonatomic,strong) UITextField  * textPassWord;
@property(nonatomic,strong) UIButton     * forgetBtn;
@property(nonatomic,strong) UIButton     * loginBtn;
@property(nonatomic,strong) UIButton     * registBtn;
@property(nonatomic,strong) UILabel      * label;
@property(nonatomic,strong) UILabel      * textLabel;
@property(nonatomic,strong) UIButton     * QQBtn;
@property(nonatomic,strong) UIButton     * WXBtn;

@end

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"登录";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
    [item setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = item;

    
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)createUI
{
    //头像
    self.headerImage = [UIImageView new];
    [self.headerImage setBackgroundColor:[UIColor redColor]];
    [self.headerImage.layer setMasksToBounds:YES];
    [self.headerImage.layer setCornerRadius:60/2];
    [self.headerImage.layer setBorderWidth:1];
    [self.headerImage.layer setBorderColor:[UIColor whiteColor].CGColor];
   
    //昵称
    self.textName = [UITextField new];
    self.textName.placeholder = @"请输入昵称";
    self.textName.font = [UIFont systemFontOfSize:16];
    self.textName.layer.borderWidth = 0.5;
    self.textName.layer.borderColor = [UIColor grayColor].CGColor;
    self.textName.layer.masksToBounds = YES;
    self.textName.layer.cornerRadius = 4;
    self.textName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textName.returnKeyType = UIReturnKeyNext;
    
    //密码
    self.textPassWord = [UITextField new];
    self.textPassWord.placeholder = @"请输入密码";
    self.textPassWord.font = [UIFont systemFontOfSize:16];
    self.textPassWord.layer.borderWidth = 0.5;
    self.textPassWord.layer.borderColor = [UIColor grayColor].CGColor;
    self.textPassWord.layer.masksToBounds = YES;
    self.textPassWord.layer.cornerRadius = 4;
    self.textPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textPassWord.returnKeyType = UIReturnKeyDone;
    self.textPassWord.secureTextEntry=YES;

    //忘记密码
    self.forgetBtn = [UIButton new];
    self.forgetBtn.layer.masksToBounds = YES;
    self.forgetBtn.layer.cornerRadius = 4;
    self.forgetBtn.backgroundColor = [UIColor blueColor];
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //登录
    self.loginBtn = [UIButton new];
    self.loginBtn.backgroundColor = [UIColor yellowColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
   
    //注册
    self.registBtn = [UIButton new];
    self.registBtn.backgroundColor = [UIColor yellowColor];
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    
    //分割线
    self.label = [UILabel new];
    self.label.backgroundColor = [UIColor grayColor];
    self.textLabel = [UILabel new];
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.textLabel.text = @"　或用以下方式登录　";
    self.textLabel.textColor = [UIColor grayColor];
    self.textLabel.font = [UIFont systemFontOfSize:12];
    [self.textLabel sizeToFit];

    
    //QQ登录
    self.QQBtn = [UIButton new];
    [self.QQBtn setImage:SetImg(@"Login_QQ_Btn") forState:UIControlStateNormal];
    
    //微信登录
    self.WXBtn = [UIButton new];
    [self.WXBtn setImage:SetImg(@"Login_WX_Btn") forState:UIControlStateNormal];
    
    
    [self.view addSubview:self.headerImage];
    [self.view addSubview:self.textName];
    [self.view addSubview:self.textPassWord];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registBtn];
    [self.view addSubview:self.label];
    [self.view addSubview:self.textLabel];
    [self.view addSubview:self.QQBtn];
    [self.view addSubview:self.WXBtn];
    [self setMasonry];
}

-(void)loginClick
{
    NSLog(@"登录");
}

-(void)registClick
{
    NSLog(@"注册");
}

-(void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)setMasonry
{
    //头像
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(64+36);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    //昵称
    [self.textName mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.headerImage.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.equalTo(@35);
    }];
    
    //密码
    [self.textPassWord mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.textName.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.forgetBtn.mas_left).offset(-10);
        make.height.equalTo(@35);
    }];
    
    //忘记密码
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.textPassWord.mas_top);
        make.right.equalTo(self.textName.mas_right);
        make.bottom.equalTo(self.textPassWord.mas_bottom);
        make.width.equalTo(@80);
    }];
    
    //登录
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.textPassWord.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(60);
        make.width.equalTo(@50);
        make.height.equalTo(@35);
    }];
    
    //注册
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.textPassWord.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-60);
        make.width.equalTo(@50);
        make.height.equalTo(@35);
    }];
    
    //横线
    [self.label mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(80);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@0.5);
    }];
    
    //字
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker * make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.label.mas_centerY);
        make.width.equalTo(@120);
        make.height.equalTo(@10);
    }];
    
    //QQ
    [self.QQBtn mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.textLabel.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_left).offset(60);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    //WX
    [self.WXBtn mas_makeConstraints:^(MASConstraintMaker * make) {
        make.top.equalTo(self.textLabel.mas_bottom).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-60);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
}

@end
