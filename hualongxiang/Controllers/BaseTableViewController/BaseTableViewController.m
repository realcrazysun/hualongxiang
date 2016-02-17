//
//  BaseTableViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "BaseTableViewController.h"
#import <MJRefresh.h>
#import "AFHTTPSessionManagerTool.h"
#import "HLXApi.h"
#import "MBProgressHUD.h"
#import "Utils.h"
#import "ResponseRootObject.h"
#import "CommonDefines.h"

@interface BaseTableViewController ()
@property(nonatomic,assign) int pageNum;

@end

@implementation BaseTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lastRefreshtime = [[NSDate date] timeIntervalSince1970];
        _objects = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _pageNum = 1;
    
    __weak __typeof(self) weakSelf = self;
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:@"ic_load_empty"];
        [idleImages addObject:image];
    }
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=2; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_loading_%zd", i]];
        [refreshingImages addObject:image];
    }

    //设置普通状态的动画图片
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // 设置普通状态的动画图片
    [header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_header = header;
    // 下拉刷新
//    self.tableView.mj_header =   [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf refresh];
//    }];
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchMore];
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
    
    
}

//刷新
-(void)refresh{
    [self fetchObjects:1 refresh:YES];
}
//刷新
-(void)fetchMore{
    [self fetchObjects:++_pageNum refresh:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%lu",_objects.count);
    return _objects.count;
}

-(NSArray*)parse:(ResponseRootObject*)response{
    //分两种情况  一种为模型  模型参数名不确定  在之类实现  一种为模型数组
    if ([response.data isKindOfClass:[NSArray class]]) {
        
        NSArray* arr = response.data;
        NSMutableArray* array = [NSMutableArray new];
        for (int i = 0; i < arr.count; i++) {
            id model = [_objClass mj_objectWithKeyValues:arr[i]];
            [array addObject:model];
        }
        return array;
    }
    return nil;
}

#pragma mark --获取数据并放入object中  如果refresh则清空当前数据
-(void)fetchObjects:(NSUInteger)page refresh:(BOOL)refresh
{
    NSDictionary* params = nil;
    if (self.generateParams) {
            params = self.generateParams(page);
    }

    [AFHTTPSessionManagerTool sendHttpPost:self.generateURL()
                                    prefix:HLXAPI_PREFIX
                                parameters:params
                                   success:^(NSURLSessionDataTask * task, id responseObject) {
                                       ResponseRootObject* model = [ResponseRootObject mj_objectWithKeyValues:responseObject];
                                       if (![model.ret isEqualToString:@"0"]) {
                                           NSLog(@"数据返回异常");
                                           ShowLoginExpireInfo
                                           return ;
                                       }
                                     
                                       if (refresh) {
                                           _pageNum = 1;
                                           [_objects removeAllObjects];//如果加载第0页则会清空当前_objects
                                       }
                                       
                                       int beforeCount = (int)[_objects count];
                                       NSArray* array = [self parse:model];
                                       for (id object in array) {
                                           BOOL shouldBeAdded = YES;
                                           id obj = [_objClass mj_objectWithKeyValues:object];
                                           
                                           for (id baseObj in _objects) {
                                               if ([obj isEqual:baseObj]) {
                                                   shouldBeAdded = NO;
                                                   break;
                                               }
                                           }
                                           if (shouldBeAdded) {
                                               [_objects addObject:obj];
                                           }
                                       }
                                       int addCount = (int)[_objects count] - beforeCount;
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                        [self.tableView reloadData];
                                           if (addCount == 0){
                                               [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                           }
                                           if (self.tableView.mj_header.isRefreshing) {
                                               [self.tableView.mj_header endRefreshing];
                                           }
                                           if(self.tableView.mj_footer.isRefreshing){
                                               [self.tableView.mj_footer endRefreshing];
                                           }
                                         
                                       });
                                       
                                   } failure:^(NSURLSessionDataTask * task, NSError * error) {
                                       MBProgressHUD *HUD = [Utils createHUD];
                                       HUD.mode = MBProgressHUDModeCustomView;
                                       HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                                       HUD.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                                       [HUD hide:YES afterDelay:1];
//                                       [self.tableView reloadData];
                                       
                                   }];
    _lastRefreshtime = [self.tableView.mj_header.lastUpdatedTime timeIntervalSince1970];
}

- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

@end
