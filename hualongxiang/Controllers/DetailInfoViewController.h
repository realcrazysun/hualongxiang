//
//  DetailInfoViewController.h
//  hualongxiang
//
//  Created by polyent on 16/1/23.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoViewController : UIViewController
-(instancetype)init:(BOOL)showBottom loadUrl:(NSString *)loadUrl liked:(BOOL)liked replyNums:(NSUInteger)replyNums ;
@end
