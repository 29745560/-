//
//  UserInfo.m
//  GNNH
//
//  Created by WYS on 16/9/5.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "UserInfo.h"

UserInfo * user = nil;

@implementation UserInfo

+(id)shareUser
{
    @synchronized (self)
    {
        if (user == nil)
        {
            user = [[UserInfo alloc]init];
        }
    }
    return user;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self)
    {
        if (user == nil)
        {
            user = [super allocWithZone:zone];
        }
    }
    return user;
}

-(id)copyWithZone:(NSZone *)zone
{
    return self;
}


@end
