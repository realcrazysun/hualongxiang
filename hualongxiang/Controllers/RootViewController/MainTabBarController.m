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
#import "HLXFriendCircleViewController.h"
#import "Config.h"
#import "UIImageView+Util.h"
#import "UIView+Util.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DynamicInfoViewController* controller1 = [self.storyboard instantiateViewControllerWithIdentifier:@"dynamicInfoViewController"];
    
    CommunityViewController* controller2 = [[CommunityViewController alloc] init];
    
    HLXFriendCircleViewController* controller3 = [[HLXFriendCircleViewController alloc] init];
    
    ChatRootViewController* controller4 = [[ChatRootViewController alloc] init];
    
    DiscoverViewController* discoverViewController = [[DiscoverViewController alloc] init];
    
    self.viewControllers = @[
                             [self addNavigationItemForViewController:controller1 rightBarBtnImgName:@"tabbar-tweet" ],
                             [self addNavigationItemForViewController:controller2 rightBarBtnImgName:@"tabbar-tweet"],
                             [self addNavigationItemForViewController:controller3 rightBarBtnImgName:@"tabbar-discover"],
                             [self addNavigationItemForViewController:controller4 rightBarBtnImgName:@"tabbar-me"],
                             [self addNavigationItemForViewController:discoverViewController rightBarBtnImgName:@"tabbar-discover"]
                             ];
    
    //底部标题栏
    NSArray *titles = @[@"动态", @"社区", @"巷友圈", @"聊天", @"发现"];
    NSArray *images = @[@"tab-1", @"tabbar-tweet", @"tabbar-news", @"tabbar-discover", @"tabbar-me"];
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
    
    //导航栏左部图标
    UIImageView* iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
    NSString* iconUrl = [Config userIconUrl];
    [iconView loadPortraitWithNSString:iconUrl defaultImgString:@"ic_default_icon"];
    [iconView setCornerRadius:iconView.frame.size.width/2];
    UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickLeftMenuButton)];
    [iconView addGestureRecognizer:recognizer];
    
    UIBarButtonItem* left = [[UIBarButtonItem alloc] initWithCustomView:iconView];

    viewController.navigationItem.leftBarButtonItem   = left;
    
    // 右边按钮不统一
    
//    viewController.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imgName]
//                                                                                         style:UIBarButtonItemStylePlain
//                                                                                        target:self action:@selector(onClickRightMenuButton)];
//    
    
    return navigationController;
}

/**
 *  打开左边侧边栏
 */
- (void)onClickLeftMenuButton{
    [self.sideMenuViewController presentLeftMenuViewController];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
