//
//  Header.h
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define HotInfoCellHeight (ScreenHeight - 150) //热点消息 cell高度
#define TodayHotCellSingleViewWidth (ScreenWidth - 4*10)/3 //今日热门 image宽度
#define TodayHotCellHeight (TodayHotCellSingleViewWidth+15*2) //今日热门 image宽度
#define NavigationBarColor [UIColor deepSkyBlue]
#define CheckUser if (![Config hasOwnId]) { LoginViewController* vc =[[LoginViewController alloc] init];UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];[self presentViewController:nav animated:YES completion:nil];return;}
#define ShowLoginExpireInfo MBProgressHUD *HUD = [Utils createHUD];HUD.mode = MBProgressHUDModeCustomView;HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];HUD.detailsLabelText = @"登陆信息过期，请重新登录";[HUD hide:YES afterDelay:1];

#endif /* Header_h */
