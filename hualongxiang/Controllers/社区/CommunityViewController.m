//
//  CommunityViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommonDefines.h"


#import "ActivityInfoController.h"
#import "HLXApi.h"
#import "CommonDefines.h"
#import "HotInfoModel.h"
#import "ActivityInfoTableViewCell.h"
#import "ActivityInfo.h"
#import "CommunityHeaderView.h"
static NSString* reuseIdentifier = @"activityInfo";
@interface CommunityViewController ()

@end

@implementation CommunityViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(NSUInteger idx){
            return [NSString stringWithFormat:@"%@", HLXAPI_ACTIVITY];
        };
        self.objClass = [ActivityInfo class];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.rowHeight = 140;
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([ActivityInfoTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    
#warning 要用tableHeaderView 而不能用viewForHeaderInSection  否则无法响应点击事件
#warning CommunityHeaderView 直接设置为tableHeaderView会出现诡异情况 。。nnd
    CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, 300);
    UIView* headerView = [[UIView alloc] initWithFrame:frame];
    
    CommunityHeaderView* view  = [[[NSBundle mainBundle]loadNibNamed:@"CommunityHeaderView" owner:nil options:nil] firstObject];
    view.frame = frame;
    [view initSubViews];
    [headerView addSubview:view];
    self.tableView.tableHeaderView = headerView ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 查一下带参数forIndexPath有神么区别 sizeToFit是什么？
    ActivityInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    [cell sizeToFit];
    ActivityInfo* info = self.objects[indexPath.row];
    [cell setModel:info];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

@end

