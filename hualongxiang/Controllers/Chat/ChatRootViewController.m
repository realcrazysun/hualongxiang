//
//  ChatRootViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "ChatRootViewController.h"
#import "CommonDefines.h"
#import "UIView+Util.h"
#import "ContactsViewController.h"
#import "NearByViewController.h"
#import "Config.h"
#import "LoginViewController.h"
@implementation ChatRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //去掉多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    //顶部导航栏 -- 标题栏
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"聊 天";
    self.navigationItem.titleView = title;
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(onClickRightMenuButton)];

}
- (void)onClickRightMenuButton{
    CheckUser
    ContactsViewController * contactsVC = [[ContactsViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:contactsVC];
    [self.navigationController pushViewController:contactsVC  animated:YES ];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
         return 4;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    UILabel* timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-120, 15, 120, 15)];
    [cell addSubview:timeLabel];
    cell.detailTextLabel.alpha = 0.5;
    [cell.imageView setCornerRadius:cell.imageView.frame.size.width/2];
    switch (indexPath.row)
    {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"chatBar_colorMore_locationSelected"];
            cell.textLabel.text = @"附近的人";
            cell.detailTextLabel.text = @"点击查看附近的人";
            break;
            
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"chatBar_colorMore_videoSelected"];
            cell.textLabel.text = @"点赞通知";
            cell.detailTextLabel.text = @"点击查看别人给你的赞哦";
            break;
            
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"chatBar_colorMore_videoCall"];
            cell.textLabel.text = @"评论通知";
            cell.detailTextLabel.text = @"点击查看别人给你的评论哦";
            break;
            
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"chatBar_colorMore_photoSelected"];
            cell.textLabel.text = @"化龙巷香香";
            cell.detailTextLabel.text = @"我";
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CheckUser
        NearByViewController* vc = [[NearByViewController alloc] init];
        [self presentViewController:vc animated:NO completion:nil];
    }
}
@end
