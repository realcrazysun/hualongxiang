//
//  BaseTableViewController.h
//  hualongxiang
//  展示信息基类
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseRootObject.h"
#import "MJExtension.h"
@interface BaseTableViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray * objects;//要展示的数据Models
@property(nonatomic,strong) Class objClass;
@property(nonatomic,copy) NSString * (^generateURL)();
@property(nonatomic,copy) NSMutableDictionary * (^generateParams)(NSUInteger page);
@property(nonatomic,assign)int64_t lastRefreshtime;
-(NSArray*)parse:(ResponseRootObject*)response;
-(void)refresh;
@end
