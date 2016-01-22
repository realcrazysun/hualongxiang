//
//  HLXRecommendTableViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/17.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HLXRecommendTableViewController.h"
#import "UIColor+Wonderful.h"
#import "HLXApi.h"
#import "HLXtopic.h"
#import "CommonDefines.h"
#import "AFHTTPSessionManagerTool.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "RecommendObject.h"
#import "HLXTodayHotCell.h"
#import "NewPostCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#define SECTIONHEIGHT 30
static NSString* identifier1 = @"identifier1";
static NSString* newPostCellIdentifier = @"newPostCell";

@interface HLXRecommendTableViewController ()
@property(nonatomic,copy) NSArray* todayHotData;//今日热门数据
@end

@implementation HLXRecommendTableViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(NSUInteger idx){
            return [NSString stringWithFormat:@"%@", HLXAPI_RECOMMEND];
        };
        self.objClass = [NewPost class];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[NewPostCell class] forCellReuseIdentifier:newPostCellIdentifier];
    
    // Do any additional setup after loading the view.
}
#warning section - 1中的数据放在同一个接口传来  这里加一点处理
-(NSArray*)parse:(ResponseRootObject*)response{
    //分两种情况  一种为模型  模型参数名不确定  在之类实现  一种为模型数组
    RecommendObject* obj = [RecommendObject mj_objectWithKeyValues:response.data];
    if (obj.bar) {
        _todayHotData = obj.bar;
    }
    return obj.list;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- delegate  datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return self.objects.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return TodayHotCellHeight;
    }else{
        CGFloat h = [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
        return h;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, SECTIONHEIGHT)];
        view.backgroundColor = [UIColor gainsboroColor];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, SECTIONHEIGHT)];
        label.text = @"今日热门";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkTextColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"更多热门 >" forState:UIControlStateNormal];
        btn.frame = CGRectMake(tableView.frame.size.width-100,0, 100, SECTIONHEIGHT);
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.alpha = 0.5;
        [view addSubview:btn];
        return view;
    }
    
    if (section == 1) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, SECTIONHEIGHT)];
        view.backgroundColor = [UIColor gainsboroColor];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, SECTIONHEIGHT)];
        label.text = @"新帖广场";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkTextColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"附近动态 >" forState:UIControlStateNormal];
        btn.frame = CGRectMake(tableView.frame.size.width-100,0 , 100, SECTIONHEIGHT);
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [view addSubview:btn];
        btn.alpha = 0.5;
        return view;
    }
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        HLXTodayHotCell* cell = [[HLXTodayHotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1 frame:CGRectMake(0, 0, ScreenWidth, TodayHotCellHeight)];
        [cell setDataArr:_todayHotData];
        return cell;
    }else {
        NewPostCell* cell = [tableView dequeueReusableCellWithIdentifier:newPostCellIdentifier];
        NewPost* model = self.objects[indexPath.row];
        [cell setModel:model];
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


//去掉悬停
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
