//
//  AppDelegate.m
//  GNNH
//
//  Created by WYS on 16/8/31.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "XHLaunchAd.h" //启动广告

@interface AppDelegate ()

@end

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    self.window.rootViewController = [[RootViewController alloc]init];
    
    
    //检查网络
    [HTTPManager checkNetWork:^(NSInteger statusIndex) {
        NSLog(@"当前网络为 = %ld",statusIndex);
    }];
    
    
    
    //加载广告页面
    //[self ADSet];
    
    
    
    //---------任务--------
    //播放器            (完成)
    //视频保存到本地     (完成)
    //进度条_旋转圆      (完成)
    //第三方集成
    //用户信息          (完成)
    //gif             (完成)
    //发段子           (完成) (发图片,视频)
    //评论             (完成)
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}


#pragma mark - 广告
-(void)ADSet
{
    XHLaunchAd *launchAd = [[XHLaunchAd alloc] initWithFrame:CGRectMake(0, 0,self.window.bounds.size.width,  self.window.bounds.size.height) andDuration:3];
    
    NSString *imgUrlString =@"http://s7.sinaimg.cn/middle/8246ad85tb55b187c2946&690";
    [launchAd imgUrlString:imgUrlString options:XHWebImageRefreshCached completed:^(UIImage *image, NSURL *url) {
        //异步加载图片完成回调(若需根据图片实际尺寸,刷新广告frame,可在这里操作)
    }];

    launchAd.hideSkip = NO;
}


@end
