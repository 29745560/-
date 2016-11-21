//
//  Tool.h
//  GNNH
//
//  Created by WYS on 16/9/2.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import <Foundation/Foundation.h>

//内容cell按钮的
typedef enum
{
    PersonClick,     //个人详情
    LikeClick,       //赞
    CollectClick,    //收藏
    ShareClick,      //分享
    CommentClick,    //评论
    ReportClick,     //举报
    PlayVideoClick   //播放
} ContentClickType;

//tabbar 类型
typedef enum
{
    PicType,
    VideoType,
    DzType
}BarType;


//显示图片 还是gif
typedef enum
{
    GifState,
    PicState
}PicShowState;



@interface Tool : NSObject

/*  获取文字的高度  */
+(CGRect)getTextRect:(NSString *)string textFont:(CGFloat)font textWidth:(CGFloat)width;

/*  获取图片的宽高  */
+(CGSize)getImageRect:(NSString *)imgWH;

/*  文件夹路径  */
+(NSString *)getFolderPath:(NSString *)folderName;

/*  计算文件夹下文件的总大小  */
+(float)fileSizeForDir:(NSString*)path;

@end
