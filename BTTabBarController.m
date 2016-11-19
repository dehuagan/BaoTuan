//
//  BTTabBarController.m
//  BaoTuan
//
//  Created by 甘徳华 on 2016/10/31.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import "BTTabBarController.h"
#import "BTHomeViewController.h"
#import "BTClassifyViewController.h"
#import "BTNewsViewController.h"
#import "BTDiscoverViewController.h"
#import "BTMeViewController.h"
@interface BTTabBarController ()
@property (nonatomic, strong) UITabBar *BTTabBar;
@end

@implementation BTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //通过appearance统一设置所有UITabBarController的字体属性
    //后面带有UI_APPEARANCE_SELECTOR方法的都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs [NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs [NSForegroundColorAttributeName] = [UIColor grayColor];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs [NSFontAttributeName] = [UIFont systemFontOfSize:12];//attrs [NSFontAttributeName]
    selectedAttrs [NSForegroundColorAttributeName] = [UIColor colorWithRed:0/255.0 green:205/255.0 blue:102/255.0 alpha:1.0];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //添加子控制器
    [self setChildvc:[[BTHomeViewController alloc]init] title:@"首页" image:@"home_2" selectedimage:@"home_2_1x"];
    [self setChildvc:[[BTClassifyViewController alloc]init] title:@"分类" image:@"category" selectedimage:@"category_2_1x"];
    [self setChildvc:[[BTNewsViewController alloc]init] title:@"消息" image:@"message" selectedimage:@"message_2_1x"];
    [self setChildvc:[[BTDiscoverViewController alloc]init] title:@"发现" image:@"find" selectedimage:@"find_2_1x"];
   
       
    [self setChildvc:[[BTMeViewController alloc]init] title:@"我" image:@"me" selectedimage:@"me_2_1x"];
    
    
    //更换tabbar
//    [self setValue:[[UITabBar alloc]init] forKey:@"tabBar"];
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar"]];
    [self.tabBar setAlpha:1.0];
    
    
}



/*
 封装添加子控件方法
 */
-(void)setChildvc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedimage:(NSString *)selectedImage
{
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
    //包装一个导航控制器，添加导航控制器为tabbarcontrolller的子控制器
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setAlpha:1.0];
    [self addChildViewController:nav];
    
}



@end
