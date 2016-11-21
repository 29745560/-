//
//  RootViewController.m
//  GNNH
//
//  Created by WYS on 16/8/31.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    UIImageView * navBarHairlineImageView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UITabBarController * tabBarController = [[UITabBarController alloc]init];
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor orangeColor];
    view.frame = tabBarController.tabBar.bounds;
    [[UITabBar appearance] insertSubview:view atIndex:0];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];


    PictureViewController * picVC = [PictureViewController new];
    picVC.tabBarItem.title = @"图片";
    picVC.navigationItem.title = @"图片";
    picVC.tabBarItem.image = SetBarImg(@"PicBarIcon");
    picVC.tabBarItem.selectedImage = SetBarImg(@"PicBarIconSel");
    UINavigationController * picNav = [[UINavigationController alloc]initWithRootViewController:picVC];
    [self setNavColor:picNav];

    VideoViewController * videoVC = [VideoViewController new];
    videoVC.tabBarItem.title = @"视频";
    videoVC.navigationItem.title = @"视频";
    videoVC.tabBarItem.image = SetBarImg(@"VideoBarIcon");
    videoVC.tabBarItem.selectedImage = SetBarImg(@"VideoBarIconSel");
    UINavigationController * videoNav = [[UINavigationController alloc]initWithRootViewController:videoVC];
    [self setNavColor:videoNav];

    
    DuanZiViewController * dzVC = [DuanZiViewController new];
    dzVC.tabBarItem.title = @"段子";
    dzVC.navigationItem.title = @"段子";
    dzVC.tabBarItem.image = SetBarImg(@"DzBarIcon");
    dzVC.tabBarItem.selectedImage = SetBarImg(@"DzBarIconSel");
    UINavigationController * dzNav = [[UINavigationController alloc]initWithRootViewController:dzVC];
    [self setNavColor:dzNav];

    SettingViewController * setVC = [SettingViewController new];
    setVC.tabBarItem.title = @"设置";
    setVC.navigationItem.title = @"设置";
    setVC.tabBarItem.image = SetBarImg(@"SetBarIcon");
    setVC.tabBarItem.selectedImage = SetBarImg(@"SetBarIconSel");
    UINavigationController * setNav = [[UINavigationController alloc]initWithRootViewController:setVC];
    [self setNavColor:setNav];
    

    NSArray * array = [NSArray arrayWithObjects:picNav,videoNav,dzNav,setNav,nil];
    tabBarController.viewControllers = array;
    tabBarController.selectedIndex = 0;
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = tabBarController;
}

-(void)setNavColor:(UINavigationController *)nav
{
    nav.navigationBar.barTintColor = [UIColor orangeColor];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    navBarHairlineImageView = [self findHairlineImageViewUnder:nav.navigationBar];
    navBarHairlineImageView.hidden = YES;
}

-(UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews)
    {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView)
        {
            return imageView;
        }
    }
    return nil;
}

@end