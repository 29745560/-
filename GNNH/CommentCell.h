//
//  CommentCell.h
//  GNNH
//
//  Created by WYS on 16/9/7.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell


//头像
@property (nonatomic ,strong) UIImageView  * headerImageView;

//名称
@property (nonatomic ,strong) UILabel      * nameLabel;

//文字内容
@property (nonatomic ,strong) UILabel      * contentLabel;


@end
