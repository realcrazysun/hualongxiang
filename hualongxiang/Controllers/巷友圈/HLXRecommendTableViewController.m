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
#import "HLXTopicCell.h"
#import "PhotoViewController.h"
#define SECTIONHEIGHT 30
static NSString* identifier1 = @"identifier1";
static NSString* newPostCellIdentifier = @"newPostCell";
static NSString* topicIndentifier = @"topicIndentifier";
@interface HLXRecommendTableViewController ()

@property(nonatomic,copy)   NSArray * topADData;   //今日广告数据
@property(nonatomic,copy)   NSArray * topics;   //话题
@property (nonatomic,copy)  NSArray * users;
@property(nonatomic,copy)   NSArray * todayHotData;//今日热门数据
@end

@implementation HLXRecommendTableViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(){
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
    [self.tableView registerClass:[HLXTopicCell class] forCellReuseIdentifier:topicIndentifier];
    // Do any additional setup after loading the view.
}
#warning section - 1中的数据放在同一个接口传来  这里加一点处理
-(NSArray*)parse:(ResponseRootObject*)response{
    RecommendObject* obj = [RecommendObject mj_objectWithKeyValues:response.data];
    if (obj.bar) {
        _todayHotData   = obj.bar;
        _topADData      = obj.top_ad;
        _topics         = obj.topics;
        _users          = obj.users;
    }
    
    return obj.list;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- delegate  datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        if (_topADData) {
            return _topADData.count;
        }
        return 0;
    }else if(section==1){
        if (_topics) {
            return _topics.count;
        }
        return 0;
    }else if(section==2){
        if (_users) {
            return _users.count;
        }
        return 0;
    }else if(section==3){
        if (_todayHotData) {
            return 1;
        }
        return 0;
    }
    else if(section==4){
        return self.objects.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else if(indexPath.section == 1){
        return 70;
    }else if(indexPath.section == 2){
        return TodayHotCellHeight;
    }else if(indexPath.section == 3){
        return TodayHotCellHeight;
    }else if(indexPath.section==4){
        CGFloat h = [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
        return h;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, SECTIONHEIGHT)];
        view.backgroundColor = [UIColor gainsboroColor];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, SECTIONHEIGHT)];
        label.text = @"顶部广告";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkTextColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"更多广告 >" forState:UIControlStateNormal];
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
        label.text = @"推荐话题";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkTextColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"更多话题 >" forState:UIControlStateNormal];
        btn.frame = CGRectMake(tableView.frame.size.width-100,0, 100, SECTIONHEIGHT);
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.alpha = 0.5;
        [view addSubview:btn];
        return view;
    }
    
    if (section == 2) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, SECTIONHEIGHT)];
        view.backgroundColor = [UIColor gainsboroColor];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, SECTIONHEIGHT)];
        label.text = @"🐂用户";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkTextColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"更多用户 >" forState:UIControlStateNormal];
        btn.frame = CGRectMake(tableView.frame.size.width-100,0, 100, SECTIONHEIGHT);
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.alpha = 0.5;
        [view addSubview:btn];
        return view;
    }
    
    if (section == 3) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, SECTIONHEIGHT)];
        view.backgroundColor = [UIColor gainsboroColor];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, SECTIONHEIGHT)];
        label.text = @"今日热门";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkTextColor];
        label.alpha = 0.5;
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"更多热门 >" forState:UIControlStateNormal];
        btn.frame = CGRectMake(tableView.frame.size.width-100,0, 100, SECTIONHEIGHT);
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.alpha = 0.5;
        [btn addTarget:self action:@selector(clickMoreHotInfo) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        return view;
    }
    
    if (section == 4) {
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
        [btn setTitleColor:[UIColor deepSkyBlue] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:btn];
        btn.alpha = 1;
        return view;
    }
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        HLXTopicCell* topicCell = [tableView dequeueReusableCellWithIdentifier:topicIndentifier];
        [topicCell setModel:[HLXTopic mj_objectWithKeyValues:_topics[indexPath.row]]];
        return topicCell;
    }
    if (indexPath.section == 3) {
        
        HLXTodayHotCell* cell = [[HLXTodayHotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1 frame:CGRectMake(0, 0, ScreenWidth, TodayHotCellHeight)];
        [cell setDataArr:_todayHotData];
        return cell;
    }else if (indexPath.section == 4){
        NewPostCell* cell = [tableView dequeueReusableCellWithIdentifier:newPostCellIdentifier];
        NewPost* model = self.objects[indexPath.row];
        [cell setModel:model];
        return cell;
    }else{
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"www"];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if (_topADData&&_topADData.count>0) {
            return 30;
        }
    }else if(section==1){
        if (_topics&&_topics.count>0) {
            return 30;
        }
    }else if(section==2&&_users.count>0){
        if (_users) {
            return _users.count;
            
        }
    }else if(section==3){
        if (_todayHotData&&_todayHotData.count>0) {
            return 30;
        }
    }
    else if(section==4){
        if (self.objects&&self.objects.count>0) {
            return 30;
        }
    }
    return 0;
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


-(void)clickMoreHotInfo{
    PhotoViewController * vc = [[PhotoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
