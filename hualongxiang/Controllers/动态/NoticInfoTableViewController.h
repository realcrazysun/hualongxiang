//
//  NoticInfoTableViewController.h
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "BaseTableViewController.h"
typedef NS_ENUM(NSInteger, NoticInfoTableViewCellType) {
    NoticInfoTableViewCellOnePic,//默认从0开始
    NoticInfoTableViewCellThreePic,
    NoticInfoTableViewCellAD,
    NoticInfoTableViewCellNone,
};
@interface NoticInfoTableViewController : BaseTableViewController


@end
