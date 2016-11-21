//
//  Tool.m
//  GNNH
//
//  Created by WYS on 16/9/2.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "Tool.h"

@implementation Tool

#pragma  mark - 获取文字的高度
+(CGRect)getTextRect:(NSString *)string textFont:(CGFloat)font textWidth:(CGFloat)width
{
    return [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
}



#pragma  mark - 获取图片的宽高
+(CGSize)getImageRect:(NSString *)imgWH
{
    if (imgWH)
    {
        //如果宽高过大，做限制，不能超出屏幕
    }
    
    return CGSizeMake(300, 150);
}



#pragma  mark - 时间精确到秒
+(NSString *)timeToSeconds:(NSString *)timeDic
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[timeDic substringToIndex:10] longLongValue]];
    return [formatter stringFromDate:confromTimesp];
}


/** 日期转换
+(NSString *)timeInterval:(NSString *)timeString
{
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:MM"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    NSString *confromTimespStr = [formatter1 stringFromDate:confromTimesp];
    return confromTimespStr;
}
*/



#pragma  mark - 文件夹路径
+(NSString *)getFolderPath:(NSString *)folderName
{
    NSString * pathString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:folderName];
    
    NSLog(@"文件夹路径 = %@",pathString);
    
    return pathString;
}



#pragma  mark - 计算文件夹下文件的总大小
+(float)fileSizeForDir:(NSString*)path
{
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    
    float size =0;
    
    NSArray * array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    for(int i = 0; i<[array count]; i++)
    {
        NSString * fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        
        if (!([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary * fileAttributeDic = [fileManager attributesOfItemAtPath:fullPath error:nil];
            size += fileAttributeDic.fileSize/ 1024.0/1024.0;
        }
        else
        {
            [self fileSizeForDir:fullPath];
        }
    }
    
    return size;
}



@end
