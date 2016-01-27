//
//  SettingPage.m
//  hualongxiang
//
//  Created by polyent on 16/1/25.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "SettingPage.h"
#import "Config.h"
#import "Utils.h"
#import "MBProgressHUD.h"
@implementation SettingPage

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
}

- (void)cancelButtonClicked{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //登陆状态和非登陆状态
    if ([Config getOwnID] == 0) {
        return 3;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 1;
        case 1: return 2;
        case 2: return 2;
        case 3: return 1;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    NSArray *titles = @[
                        @[@"消息通知"],
                        @[@"浏览记录",@"消息缓存"],
                        @[ @"关于我们",@"意见反馈"],
                        @[@"注销登录"],
                        ];
    cell.textLabel.text = titles[indexPath.section][indexPath.row];
//    cell.backgroundColor = [UIColor cellsColor];
//    cell.textLabel.textColor = [UIColor titleColor];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section, row = indexPath.row;
    
    if(section == 3){
        [Config clearProfile];
        //注销登陆
        MBProgressHUD *HUD = [Utils createHUD];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
        HUD.labelText = @"注销成功";
        [HUD hide:YES afterDelay:0.5];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:@(YES)];
        
        //
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }

//    
//    if (section == 0) {
//        if (row == 0) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定要清除缓存的图片和文件？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alertView show];
//            
//        } else if (row == 1){
//            
//        }
//    } else if (section == 1) {
//        if (row == 0) {
//            [self.navigationController pushViewController:[FeedbackPage new] animated:YES];
//        } else if (row == 1) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/kai-yuan-zhong-guo/id524298520?mt=8"]];
//        } else if (row == 2) {
//            [self.navigationController pushViewController:[AboutPage new] animated:YES];
//        } else if (row == 3) {
//            [self.navigationController pushViewController:[OSLicensePage new] animated:YES];
//        }
//    } else if (section == 2) {
//        [Config clearProfile];
//        [Config removeTeamInfo];
//        [Config clearCookie];
//        
//        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
//            [cookieStorage deleteCookie:cookie];
//        }
//        
//        MBProgressHUD *HUD = [Utils createHUD];
//        HUD.mode = MBProgressHUDModeCustomView;
//        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-done"]];
//        HUD.labelText = @"注销成功";
//        [HUD hide:YES afterDelay:0.5];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:@(YES)];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//    }
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        return;
    } else {
        //清除缓存
//        [[NSURLCache sharedURLCache] removeAllCachedResponses];
//        [[SDImageCache sharedImageCache] clearMemory];
//        [[SDImageCache sharedImageCache] clearDisk];
    }
}



@end
