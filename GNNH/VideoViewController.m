//
//  VideoViewController.m
//  GNNH
//
//  Created by WYS on 16/8/31.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "VideoViewController.h"
#import "DetailViewController.h"
#import "WMPlayer.h"

#import <QuartzCore/QuartzCore.h>
#import "DAProgressOverlayView.h"

static NSString * urls = @"http://flv2.bn.netease.com/videolib3/1609/07/vSpOm4477/SD/vSpOm4477-mobile.mp4";
static NSString * Identifier = @"VideoCell";

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,ContentCellDelegate>
@property (nonatomic ,strong) UITableView   * videoTableView;
@property (nonatomic ,strong) WMPlayer      * wmPlayer;
@property (nonatomic ,strong) NSIndexPath   * currentIndexPath;
@property (strong, nonatomic) DAProgressOverlayView * progressOverlayView;

@end

@implementation VideoViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.videoTableView = [[UITableView alloc]initWithFrame:SetScreenBounds style:UITableViewStyleGrouped];
    [self.videoTableView setDelegate:self];
    [self.videoTableView setDataSource:self];
    [self.videoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.videoTableView setSeparatorColor:[UIColor whiteColor]];
    [self.view addSubview:self.videoTableView];
    
    
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];

    //播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTheVideo:)name:@"closeTheVideo" object:nil];
}

#pragma mark - 视频操作
/*  结束  */
-(void)videoDidFinished:(NSNotification *)notice
{
    [self.wmPlayer removeFromSuperview];
    
    ContentCell * curCell = [self.videoTableView cellForRowAtIndexPath:self.currentIndexPath];
    [curCell.playBtn setHidden:NO];
}


/*  关闭  */
-(void)closeTheVideo:(NSNotification *)obj
{
    [self releaseWMPlayer];
    
    ContentCell * curCell = [self.videoTableView cellForRowAtIndexPath:self.currentIndexPath];
    [curCell.playBtn setHidden:NO];
}


/*  全屏  */
-(void)fullScreenBtnClick:(NSNotification *)notice
{
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected)
    {
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }
    else
    {
       [self toNormal];
    }
}


/*  点击播放  */
-(void)playVideo:(ContentCell *)curCell
{
    self.currentIndexPath = [self.videoTableView indexPathForCell:curCell];

    [curCell.playBtn setHidden:YES];
    
    AFHTTPRequestOperation * operation = [HTTPManager downloadFileURL:urls savePath:[Tool getFolderPath:VideoFolderName] fileName:@"video1.mp4"];
    
    if (operation == 0)
    {
        NSLog(@"该文件已下载");
        
        [self createWMPlayer:curCell];
    }
    else
    {
        //如果不存在进度条
        if (!self.progressOverlayView)
        {
            self.progressOverlayView = [[DAProgressOverlayView alloc] initWithFrame:curCell.playerView.bounds];
            self.progressOverlayView.innerRadiusRatio = 0.5f; //外圈
            self.progressOverlayView.outerRadiusRatio = 0.6f; //内圈
            
            [curCell.playerView addSubview:self.progressOverlayView];
        }
        
        
        [self.progressOverlayView setHidden:NO];
        [self.progressOverlayView displayOperationWillTriggerAnimation];
    
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            
            CGFloat valueFloat = (float)totalBytesRead/totalBytesExpectedToRead;
            
            [self.progressOverlayView setProgress:valueFloat];

            if (valueFloat >= 1.0f)
            {
                [self.progressOverlayView displayOperationDidFinishAnimation];
                [self.progressOverlayView setProgress:0.0f];
                [self.progressOverlayView setHidden:YES];
                
                NSLog(@"-----下载完成1111111-----");
            }
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * operation, id responseObject) {
            
            NSLog(@"-----下载完成2222222-----");
           
            [self createWMPlayer:curCell];

        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            
        }];
    }
}


/*  创建播放器  */
-(void)createWMPlayer:(ContentCell *)curCell
{
    NSString * fileStr = [NSString stringWithFormat:@"%@/%@", [Tool getFolderPath:VideoFolderName], @"video1.mp4"];
    
    if (self.wmPlayer)
    {
        [self.wmPlayer removeFromSuperview];
        [self.wmPlayer setVideoURLStr:fileStr];
        [self.wmPlayer.player play];
    }
    else
    {
        self.wmPlayer = [[WMPlayer alloc]initWithFrame:curCell.playerView.bounds videoURLStr:fileStr];

        [self.wmPlayer.player play];
    }
    
    [curCell.playerView addSubview:self.wmPlayer];
    [curCell.playerView bringSubviewToFront:self.wmPlayer];
}



#pragma mark - tableview delegate datasource
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
    //CGSize imageSize = [Tool getImageRect:@" dic[indexPath.section][url] "];
    
    CGRect textRect = [Tool getTextRect:@"我呵呵空间哦窘迫和我你那么" textFont:14 textWidth:MainWidth-10];
    
    CGFloat height = 5+30+5+textRect.size.height+10+5+ MainWidth/2 +5+20+5;
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    if (!cell)
    {
        cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier typeIndex:VideoType infoNSDictionary:nil];
    }

    cell.delegate = self;

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * vc = [[DetailViewController alloc]initWithType:VideoType];
    GoToNextVC
}


#pragma mark - ContentCell  Delegate
-(void)contentButtonClick:(NSInteger)clickType contentCell:(ContentCell *)cell
{
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
            
        case PlayVideoClick:
            
            [self playVideo:cell];
            
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

#pragma mark - NSNotificationCenter
-(void)toNormal
{
    ContentCell * curCell = [self.videoTableView cellForRowAtIndexPath:self.currentIndexPath];
    
    [self.wmPlayer removeFromSuperview];
    
    [UIView animateWithDuration:0.2f animations:^{
       
        self.wmPlayer.transform = CGAffineTransformIdentity;
        self.wmPlayer.frame = curCell.playerView.bounds;
        self.wmPlayer.playerLayer.frame =  self.wmPlayer.bounds;
        [curCell.playerView addSubview:self.wmPlayer];
        [curCell.playerView bringSubviewToFront:self.wmPlayer];
       
        [self.wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wmPlayer).with.offset(0);
            make.right.equalTo(self.wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.wmPlayer).with.offset(0);
        }];
        
        [self.wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(self.wmPlayer).with.offset(5);
        }];
    
    }completion:^(BOOL finished) {
        
        self.wmPlayer.isFullscreen = NO;
        self.wmPlayer.fullScreenBtn.selected = NO;
    }];
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation
{
    [self.wmPlayer removeFromSuperview];
    self.wmPlayer.transform = CGAffineTransformIdentity;
   
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
    {
        self.wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
        self.wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.wmPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.wmPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
    
    [self.wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view.frame.size.width-40);
        make.width.mas_equalTo(self.view.frame.size.height);
    }];
    
    [self.wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wmPlayer).with.offset((-self.view.frame.size.height/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(self.wmPlayer).with.offset(5);
        
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.wmPlayer];
    self.wmPlayer.isFullscreen = YES;
    self.wmPlayer.fullScreenBtn.selected = YES;
    [self.wmPlayer bringSubviewToFront:self.wmPlayer.bottomView];
}

-(void)releaseWMPlayer
{
    [self.wmPlayer.player.currentItem cancelPendingSeeks];
    [self.wmPlayer.player.currentItem.asset cancelLoading];
    [self.wmPlayer.player pause];
    [self.wmPlayer removeFromSuperview];
    [self.wmPlayer.playerLayer removeFromSuperlayer];
    [self.wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    
    self.wmPlayer = nil;
    self.wmPlayer.player = nil;
    self.wmPlayer.currentItem = nil;
    self.wmPlayer.playOrPauseBtn = nil;
    self.wmPlayer.playerLayer = nil;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
}

@end
