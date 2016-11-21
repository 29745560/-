//
//  SettingViewController.m
//  GNNH
//
//  Created by WYS on 16/8/31.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "SettingViewController.h"
#import "MyCollectViewController.h"
#import "LoginViewController.h"

#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "XHLaunchAd.h"

static NSString * SC_Identifier = @"SC_CELL";
static NSString * MZ_Identifier = @"MZ_CELL";
static NSString * QC_Identifier = @"QC_CELL";
static NSString * TJ_Identifier = @"TJ_CELL";
static NSString * PJ_Identifier = @"PJ_CELL";

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITableView  * settingTableView;
@property (nonatomic,strong) UIImageView  * headerView;
@property (nonatomic,strong) UIButton     * imageViewBtn;
@property (nonatomic,strong) UIButton     * nameLabelBtn;

@end

@implementation SettingViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.settingTableView = [[UITableView alloc]initWithFrame:SetScreenBounds style:UITableViewStyleGrouped];
    [self.settingTableView setDataSource:self];
    [self.settingTableView setDelegate:self];
    [self.settingTableView setContentInset:UIEdgeInsetsMake(150, 0, 0, 0)];
    [self.view addSubview:self.settingTableView];
    
    
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SC_Identifier];
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MZ_Identifier];
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:QC_Identifier];
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TJ_Identifier];
    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PJ_Identifier];

    
    // 设置表头View
    self.headerView = [[UIImageView alloc]initWithImage:SetImg(@"HeaderImage")];
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerView.frame = CGRectMake(0, -150, MainWidth, 300);
    self.headerView.userInteractionEnabled = YES;
    [self.settingTableView insertSubview:self.headerView atIndex:0];
    [self.settingTableView addSubview:self.headerView];
    
    
    //头像
    self.imageViewBtn = [UIButton new];
    self.imageViewBtn.backgroundColor = [UIColor redColor];
    [self.imageViewBtn.layer setMasksToBounds:YES];
    [self.imageViewBtn.layer setCornerRadius:60/2];
    [self.imageViewBtn.layer setBorderWidth:0.8];
    [self.imageViewBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.imageViewBtn addTarget:self action:@selector(changeHeaderClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.imageViewBtn];
    [self.imageViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX);
        make.centerY.equalTo(self.headerView.mas_centerY).offset(-15);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    self.nameLabelBtn = [UIButton new];
    self.nameLabelBtn.backgroundColor = [UIColor blackColor];
    self.nameLabelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.nameLabelBtn setTitle:@"点击登录" forState:UIControlStateNormal];
    [self.nameLabelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nameLabelBtn addTarget:self action:@selector(changeNameClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.nameLabelBtn];
    [self.nameLabelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX);
        make.top.equalTo(self.imageViewBtn.mas_bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y + 64;
    
    if(yOffset < -149)
    {
        CGRect frame = self.headerView.frame;
        frame.origin.y= yOffset;
        frame.size.height = -yOffset;
        self.headerView.frame = frame;
    }
}

#pragma mark - tableView delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 0.1;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell * cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:SC_Identifier forIndexPath:indexPath];
            
            cell.textLabel.text = @"我的收藏";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = SetImg(@"CollectBtnIcon");

            return cell;
        }
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:MZ_Identifier forIndexPath:indexPath];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"免责声明";
            cell.imageView.image = SetImg(@"MZ_Icon");

            return cell;
        }
        else
        {
            UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:QC_Identifier forIndexPath:indexPath];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"清除缓存";
            cell.imageView.image = SetImg(@"QC_Icon");

            return cell;
        }
    }
    
    else
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:TJ_Identifier forIndexPath:indexPath];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"推荐给好友";
            cell.imageView.image = SetImg(@"ShareBtnIcon");
            
            return cell;
        }
        else
        {
            UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:PJ_Identifier forIndexPath:indexPath];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"评价此应用";
            cell.imageView.image = SetImg(@"PJ_Icon");
            
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.section)
    {
        case 0:
            if (indexPath.row == 0)
            {
                //我的收藏
                MyCollectViewController * vc = [[MyCollectViewController alloc]init];
                GoToNextVC
            }
            break;
            
        case 1:
            if (indexPath.row == 0)
            {
                //免责声明
            }
            else
            {
                //清除缓存
                float allCache = (float)[[SDImageCache sharedImageCache] getSize]/1024/1024 + [XHLaunchAd imagesCacheSize] + [Tool fileSizeForDir:[Tool getFolderPath:VideoFolderName]];
                
                NSString * titleMsg = [NSString stringWithFormat:@"已使用%.2fM缓存,是否要删除所有的缓存数据？",allCache];
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:titleMsg message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即清理", nil];
                
                alert.tag = 12;
                
                [alert show];
            }
            break;
            
        case 2:
            if (indexPath.row == 0)
            {
                //推荐给好友
            }
            else
            {
                //评价此应用
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"应用评分" message:@"应用开发工程狮小白，由于每天加班特辛苦，至今未谈对象，希望您给个好评" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去评分", nil];
               
                alert.tag = 22;
                
                [alert show];
            }
            break;
    }
}

#pragma mark - alertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 12)
    {
        if (buttonIndex == 1)
        {
            //删除缓存文件
            if ([[NSFileManager defaultManager] fileExistsAtPath:[Tool getFolderPath:VideoFolderName]])
            {
                BOOL isDelete = [[NSFileManager defaultManager] removeItemAtPath:[Tool getFolderPath:VideoFolderName] error:nil];
                NSLog(@"删除 ---> %@",isDelete == YES ?@"成功":@"失败");
            }
            else
            {
                NSLog(@"没有文件，删毛线");
            }
            
            
            [XHLaunchAd clearDiskCache];
            [[[SDWebImageManager sharedManager] imageCache] clearMemory];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [SVProgressHUD showSuccessWithStatus:@"清理完成"];
                [self performSelector:@selector(SVDisMiss) withObject:self afterDelay:1];
            }];
        }
    }
    if (alertView.tag == 22)
    {
        //评价此应用
        if (buttonIndex == 1)
        {
            NSLog(@"评价此应用");
        }
    }
    if (alertView.tag == 100)
    {
        NSLog(@"发送修改后的昵称");
        //如果完成
        //在请求成功 后，设置 button  的  text
    }
}


#pragma mark - 按钮事件
-(void)changeHeaderClick
{
    //修改头像
//    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
//    [sheet showInView:self.view];
    
    
    
    //-------得先判断是否登录---------
    LoginViewController * vc = [[LoginViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]init];
    [nav addChildViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

-(void)changeNameClick
{
    //修改昵称
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"修改昵称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].placeholder = @"请输入新昵称";
    alert.tag = 100;
    alert.delegate = self;
    [alert show];
}

#pragma mark - UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            NSLog(@"相册");
            [self openSystemPhotoLibrary];
            break;
       
        case 1:
            NSLog(@"拍照");
            [self openSystemCarmera];
            break;
    }
}

//打开相册
-(void)openSystemPhotoLibrary
{
    UIImagePickerController * imgPicker = [UIImagePickerController new];
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.allowsEditing = YES;
    imgPicker.delegate = self;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

//打开相机
-(void)openSystemCarmera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController * imgPicker = [UIImagePickerController new];
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgPicker.allowsEditing = YES;
        imgPicker.delegate = self;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
    else
    {
        NSLog(@"打开相机失败");
    }
}


#pragma mark - UIImagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (info[UIImagePickerControllerMediaType])
    {
        UIImage * editedImg = info[UIImagePickerControllerEditedImage];
    
        NSData * data = nil;
        
        if (UIImagePNGRepresentation(editedImg))
        {
            data = UIImagePNGRepresentation(editedImg);
        }
        else
        {
            data = UIImageJPEGRepresentation(editedImg, .1);
        }
        
        //把 data 上传到服务器
        //如果上传成功
        [self.imageViewBtn setImage:editedImg forState:UIControlStateNormal];

        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
-(void)SVDisMiss
{
    [SVProgressHUD dismiss];
}

@end
