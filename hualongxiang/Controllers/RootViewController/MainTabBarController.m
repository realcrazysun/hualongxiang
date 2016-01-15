//
//  MainTabBarController.m
//  hualongxiang
//
//  Created by polyent on 16/1/9.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationViewController.h"
#import "DiscoverViewController.h"
#import <RESideMenu/RESideMenu.h>
#import "ChatRootViewController.h"
#import "DynamicInfoViewController.h"
#import "CommunityViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DynamicInfoViewController* controller1 = [self.storyboard instantiateViewControllerWithIdentifier:@"dynamicInfoViewController"];
    
    CommunityViewController* controller2 = [[CommunityViewController alloc] init];
//    controller2.view.backgroundColor = [UIColor blueColor];
    
    UIViewController* controller3 = [[UIViewController alloc] init];
    controller3.view.backgroundColor = [UIColor yellowColor];
    
    ChatRootViewController* controller4 = [[ChatRootViewController alloc] init];
    
    DiscoverViewController* discoverViewController = [[DiscoverViewController alloc] init];
    
    self.viewControllers = @[
                             [self addNavigationItemForViewController:controller1 rightBarBtnImgName:@"tabbar-news" ],
                             [self addNavigationItemForViewController:controller2 rightBarBtnImgName:@"tabbar-tweet"],
                             [self addNavigationItemForViewController:controller3 rightBarBtnImgName:@"tabbar-discover"],
                             [self addNavigationItemForViewController:controller4 rightBarBtnImgName:@"tabbar-me"],
                             [self addNavigationItemForViewController:discoverViewController rightBarBtnImgName:@"tabbar-discover"]
                             ];
    
    //底部标题栏
    NSArray *titles = @[@"动态", @"社区", @"巷友圈", @"聊天", @"发现"];
    NSArray *images = @[@"tabbar-news", @"tabbar-tweet", @"tabbar-news", @"tabbar-discover", @"tabbar-me"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
        [item setSelectedImage:[UIImage imageNamed:[images[idx] stringByAppendingString:@"-selected"]]];
    }];
    
}

- (UINavigationController *)addNavigationItemForViewController:(UIViewController *)viewController
                                            rightBarBtnImgName:(NSString*)imgName
{
    
    BaseNavigationViewController *navigationController = [[BaseNavigationViewController alloc] initWithRootViewController:viewController];
    
    UIBarButtonItem* left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar-news"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self action:@selector(onClickLeftMenuButton)];
    
    viewController.navigationItem.leftBarButtonItem   = left;
    // 右边按钮不统一
    
    viewController.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imgName]
                                                                                        style:UIBarButtonItemStylePlain
                                                                                       target:self action:@selector(onClickRightMenuButton)];
    
    return navigationController;
}

/**
 *  打开左边侧边栏
 */
- (void)onClickLeftMenuButton{
    [self.sideMenuViewController presentLeftMenuViewController];
}

/**
 *  点击右边侧边栏按钮
 */
- (void)onClickRightMenuButton{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
