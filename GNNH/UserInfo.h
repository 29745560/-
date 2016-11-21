//
//  UserInfo.h
//  GNNH
//
//  Created by WYS on 16/9/5.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+(id)shareUser;

//如果在单线程里可以用nonatomic,如果在多线程里一定要用atomic,保证是只有一个在调用,不然在多线程里面如果多个方法调用修改单例类里的属性时会冲突

//用户名
@property (nonatomic,strong) NSString  * user_name;
//用户ID
@property (nonatomic,strong) NSString  * user_id;
//用户密码
@property (nonatomic,assign) NSInteger   user_password;
//用户手机号
@property (nonatomic,assign) NSInteger   user_phoneNumber;
//用户登录状态
@property (nonatomic,assign) BOOL        user_isLogin;







@end
