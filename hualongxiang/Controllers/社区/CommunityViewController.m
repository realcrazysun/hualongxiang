//
//  CommunityViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommonDefines.h"

#import "AFHTTPSessionManagerTool.h"
#import "ActivityInfoController.h"
#import "HLXApi.h"
#import "CommonDefines.h"
#import "HotInfoModel.h"
#import "ActivityInfoTableViewCell.h"
#import "ActivityInfo.h"
#import "CommunityHeaderView.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "CommuityModel.h"
#import "MJRefresh.h"
#import "NSDateFormatter+Singleton.h"
#import "AllBlocksViewController.h"
#import "EditViewController.h"
static NSString* reuseIdentifier = @"activityInfo";
@interface CommunityViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)CommunityHeaderView* head;
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
    
    //顶部导航栏 -- 标题栏
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"社 区";
    self.navigationItem.titleView = title;
    
    //顶部导航栏 -- rightBarButtonItem
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_forum_publish"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(onClickRightMenuButton)];
    
    
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([ActivityInfoTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    
    
#warning 要用tableHeaderView 而不能用viewForHeaderInSection  否则无法响应点击事件
#warning CommunityHeaderView 直接设置为tableHeaderView会出现诡异情况 。。nnd
    CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, 300);
    UIView* view = [[UIView alloc] initWithFrame:frame];
    _head  = [[[NSBundle mainBundle]loadNibNamed:@"CommunityHeaderView" owner:nil options:nil] firstObject];
    _head.frame = frame;
    [view addSubview:_head];
    _head.scrollView.delegate = self;
    self.tableView.tableHeaderView = view ;
    
}

/**
 *  导航栏rightBarButtonItem点击事件
 */
-(void)onClickRightMenuButton{
    EditViewController *vc = [[EditViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}


-(void)refresh{
    [super refresh];
    
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_JUHEBANKUAI
                                    prefix:HLXAPI_PREFIX
                                parameters:nil
                                   success:^(NSURLSessionDataTask * task, id responseObject) {
                                       ResponseRootObject* model = [ResponseRootObject mj_objectWithKeyValues:responseObject];
                                       if (![model.ret isEqualToString:@"0"]) {
                                           NSLog(@"数据返回异常");
                                       }
                                       CommuityModel* comModel = [CommuityModel mj_objectWithKeyValues:model.data];
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           NSDateFormatter* formatter =  [NSDateFormatter new];
                                           formatter.dateFormat = @"MM-dd HH:mm";
                                           NSString* time = [formatter stringFromDate:self.tableView.mj_header.lastUpdatedTime];
                                           [_head initData:comModel.attention recommend:comModel.recommend lastRefreshTime:time];
                                       });
                                       
                                   }
                                   failure:^(NSURLSessionDataTask * task, NSError * error) {
                                       MBProgressHUD *HUD = [Utils createHUD];
                                       HUD.mode = MBProgressHUDModeCustomView;
                                       HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                                       HUD.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                                       [HUD hide:YES afterDelay:1];
                                       [self.tableView reloadData];
                                       
                                   }];
    
    
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

#pragma mark--scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    _head.pageControl.currentPage = (_head.scrollView.contentOffset.x/_head.scrollView.frame.size.width);
    //    NSLog(@"%d",_head.pageControl.currentPage);
}
@end

