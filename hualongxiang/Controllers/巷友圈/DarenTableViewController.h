//
//  DarenTableViewController.h
//  hualongxiang
//
//  Created by polyent on 16/1/28.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "BaseTableViewController.h"
typedef NS_ENUM(NSUInteger, DaRenType) {
    Total = 0,
    TwentyFourHour,//24小时

};

@interface DarenTableViewController : BaseTableViewController
-(instancetype)initWithType:(DaRenType) type;
@end
