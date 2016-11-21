//
//  CommentCell.m
//  GNNH
//
//  Created by WYS on 16/9/7.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
#pragma mark 头像
        self.headerImageView = [UIImageView new];
        [self.headerImageView setBackgroundColor:[UIColor cyanColor]];
        [self.headerImageView.layer setMasksToBounds:YES];
        [self.headerImageView.layer setCornerRadius:20/2];
        [self.headerImageView.layer setBorderWidth:0.2];
        [self.headerImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.contentView addSubview:self.headerImageView];
        
#pragma mark 名称
        self.nameLabel = [UILabel new];
        [self.nameLabel setFont:[UIFont systemFontOfSize:12]];
        [self.nameLabel setText:@"黑夜里的菊花"];
        [self.nameLabel setTextColor:[UIColor grayColor]];
        [self.nameLabel setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:self.nameLabel];
        
#pragma mark 文字内容
        self.contentLabel = [UILabel new];
        [self.contentLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentLabel setText:@"我呵呵空间哦窘迫和我你那么"];
        [self.contentLabel setTextColor:[UIColor blackColor]];
        [self.contentLabel setNumberOfLines:0];
        [self.contentLabel setBackgroundColor:[UIColor yellowColor]];
        [self.contentLabel sizeToFit];
        [self.contentView addSubview:self.contentLabel];
        
        [self SetMasonry];
    }
    return self;
}


-(void)SetMasonry
{
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(_headerImageView.mas_top);
        make.height.equalTo(@20);
    }];
   
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];
}








-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
