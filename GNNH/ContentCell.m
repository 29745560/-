//
//  ContentCell.m
//  GNNH
//
//  Created by WYS on 16/8/31.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier typeIndex:(NSInteger)styleIndex infoNSDictionary:(NSDictionary *)infoDic;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //传进来内容

#pragma mark 头像
        self.headerImageBtn = [UIButton new];
        [self.headerImageBtn setTag:PersonClick];
        [self.headerImageBtn setBackgroundColor:[UIColor redColor]];
        [self.headerImageBtn.layer setMasksToBounds:YES];
        [self.headerImageBtn.layer setCornerRadius:30/2];
        [self.headerImageBtn.layer setBorderWidth:0.5];
        [self.headerImageBtn.layer setBorderColor:[UIColor blackColor].CGColor];
        [self.headerImageBtn addTarget:self action:@selector(BtnEventClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.headerImageBtn];

#pragma mark 名称
        self.nameLabel = [UILabel new];
        [self.nameLabel setFont:[UIFont systemFontOfSize:10]];
        [self.nameLabel setText:@"内涵图片"];
        [self.nameLabel setTextColor:[UIColor grayColor]];
        [self.nameLabel setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:self.nameLabel];

#pragma mark 时间
        self.timeLabel = [UILabel new];
        [self.timeLabel setFont:[UIFont systemFontOfSize:10]];
        [self.timeLabel setText:@"2016-08-31 17:20:00"];
        [self.timeLabel setTextColor:[UIColor grayColor]];
        [self.timeLabel setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:self.timeLabel];
        
#pragma mark 举报按钮
        self.reportBtn = [UIButton new];
        [self.reportBtn setBackgroundColor:[UIColor magentaColor]];
        [self.reportBtn setTitle:@"举报" forState:UIControlStateNormal];
        [self.reportBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.reportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.reportBtn setTag:ReportClick];
        [self.reportBtn addTarget:self action:@selector(BtnEventClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.reportBtn];

#pragma mark 文字内容
        self.contentLabel = [UILabel new];
        [self.contentLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentLabel setText:@"我呵呵空间哦窘迫和我你那么"];
        [self.contentLabel setTextColor:[UIColor blackColor]];
        [self.contentLabel setNumberOfLines:0];
        [self.contentLabel setBackgroundColor:[UIColor yellowColor]];
        [self.contentLabel sizeToFit];
        [self.contentView addSubview:self.contentLabel];

#pragma mark 赞
        self.likeBtn = [UIButton new];
        [self.likeBtn setBackgroundColor:[UIColor yellowColor]];
        [self.likeBtn setTitle:@"赞 1234" forState:UIControlStateNormal];
        [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.likeBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self.likeBtn setTag:LikeClick];
        [self.likeBtn addTarget:self action:@selector(BtnEventClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.likeBtn];

#pragma mark 收藏
        self.collectBtn = [UIButton new];
        [self.collectBtn setTag:CollectClick];
        [self.collectBtn setImage:SetImg(@"CollectBtnIcon") forState:UIControlStateNormal];
        [self.collectBtn addTarget:self action:@selector(BtnEventClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.collectBtn];

#pragma mark 分享
        self.shareBtn = [UIButton new];
        [self.shareBtn setTag:ShareClick];
        [self.shareBtn setImage:SetImg(@"ShareBtnIcon") forState:UIControlStateNormal];
        [self.shareBtn addTarget:self action:@selector(BtnEventClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.shareBtn];

#pragma mark 评论
        self.commentBtn = [UIButton new];
        [self.commentBtn setTag:CommentClick];
        [self.commentBtn setImage:SetImg(@"CommentBtnIcon") forState:UIControlStateNormal];
        [self.commentBtn addTarget:self action:@selector(BtnEventClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.commentBtn];

        NSLog(@"------click ------   bar state = %ld",styleIndex);
        
#pragma mark 不同类型显示的内容
        if (styleIndex == PicType)
        {
            self.gifImgView = [[FLAnimatedImageView alloc] init];
            self.gifImgView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
            self.gifImgView.contentMode = UIViewContentModeScaleAspectFit;
            self.gifImgView.clipsToBounds = YES;
            [self.contentView addSubview:self.gifImgView];
            
            NSLog(@"传进来的图片状态  -----  %@",infoDic[@"viewIndex"]);
            
            if ([infoDic[@"viewIndex"] isEqualToString:@"0"])
            {
                [self.gifImgView sd_setImageWithURL:[NSURL URLWithString:@"http://scimg.jb51.net/allimg/160815/103-160Q509544OC.jpg"] placeholderImage:nil];
            }
            else
            {
                self.gifImgView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ww1.sinaimg.cn/large/85cccab3gw1etdi67ue4eg208q064n50.jpg"]]];
            }
        }
        else if (styleIndex == VideoType)
        {
            //蒙版
            self.playerView = [UIView new];
            self.playerView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0];
            [self.contentView addSubview:self.playerView];
            
            
            //播放按钮
            self.playBtn = [UIButton new];
            self.playBtn.tag = PlayVideoClick;
            [self.playBtn setImage:SetImg(@"video_play_btn_bg") forState:UIControlStateNormal];
            [self.playBtn addTarget:self action:@selector(BtnEventClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.playerView addSubview:self.playBtn];
        }
        else
        {
            //什么都不显示
        }

        [self SetMasonry:styleIndex];
    }
    return self;
}

-(void)SetMasonry:(NSInteger)typeNum;
{
    CGRect contextRect = [Tool getTextRect:self.contentLabel.text textFont:14 textWidth:MainWidth-10];

    CGSize imgSize = [Tool getImageRect:@"url 截取的 宽高"];
    
    
    //头像
    [_headerImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    //名称
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageBtn.mas_right).offset(10);
        make.top.equalTo(_headerImageBtn.mas_top);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    //时间
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageBtn.mas_right).offset(10);
        make.bottom.equalTo(_headerImageBtn.mas_bottom);
        make.width.equalTo(@200);
        make.height.equalTo(@10);
    }];
    
    //举报
    [_reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(_headerImageBtn.mas_top);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    //内容
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageBtn.mas_left);
        make.top.equalTo(_headerImageBtn.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.height.equalTo(@(contextRect.size.height+10));
    }];
    
    //喜欢
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];

    //评论
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];

    //分享
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_commentBtn.mas_left).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    //收藏
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_shareBtn.mas_left).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    if (typeNum == PicType)
    {
        //可以在外面设置
        [_gifImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            //   make.centerX.equalTo(self.contentView.mas_centerX);
            //   make.top.equalTo(_contentLabel.mas_bottom).offset(5);
            //   make.height.equalTo(@(imgSize.height));
            //   make.width.equalTo(@(imgSize.width));
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(_contentLabel.mas_bottom).offset(5);
            make.height.equalTo(@(imgSize.height));
        }];
    }
    else if (typeNum == VideoType)
    {
        [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(_contentLabel.mas_bottom).offset(5);
            make.height.equalTo(@(MainWidth/2));
        }];
        
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.playerView.mas_centerX);
            make.centerY.equalTo(self.playerView.mas_centerY);
            make.height.equalTo(@60);
            make.width.equalTo(@60);
        }];
    }
    else
    {
        //不显示
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)BtnEventClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(contentButtonClick:contentCell:)])
    {
        [self.delegate contentButtonClick:button.tag contentCell:self];
    }
    else
    {
        NSLog(@"没有完成代理");
    }
}

@end
