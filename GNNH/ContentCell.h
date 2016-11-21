//
//  ContentCell.h
//  GNNH
//
//  Created by WYS on 16/8/31.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"

@class ContentCell;

@protocol ContentCellDelegate <NSObject>

@optional
-(void)contentButtonClick:(NSInteger)clickType contentCell:(ContentCell *)cell;

@end


@interface ContentCell : UITableViewCell

//头像
@property (nonatomic ,strong) UIButton     * headerImageBtn;

//名称
@property (nonatomic ,strong) UILabel      * nameLabel;

//时间
@property (nonatomic ,strong) UILabel      * timeLabel;

//举报按钮
@property (nonatomic ,strong) UIButton     * reportBtn;

//文字内容
@property (nonatomic ,strong) UILabel      * contentLabel;

//赞
@property (nonatomic ,strong) UIButton     * likeBtn;

//收藏
@property (nonatomic ,strong) UIButton     * collectBtn;

//分享
@property (nonatomic ,strong) UIButton     * shareBtn;

//评论
@property (nonatomic ,strong) UIButton     * commentBtn;



/**
 *  图片内容   (gif  和  image)
 */
@property (nonatomic ,strong) FLAnimatedImageView * gifImgView;
@property (nonatomic ,assign) NSInteger viewStateIndex;



/**
 *  视频内容  （蒙版  和  播放按钮）
 */
@property (nonatomic ,strong) UIView       * playerView;
@property (nonatomic ,strong) UIButton     * playBtn;





//----------
@property (nonatomic ,assign) id <ContentCellDelegate> delegate;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier typeIndex:(NSInteger)styleIndex infoNSDictionary:(NSDictionary *)infoDic;
@end
