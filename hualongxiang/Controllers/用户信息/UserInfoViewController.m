//
//  UserInfoViewController.m
//  hualongxiang
//  利用tableView的contentInset属性实现向上移动
//  Created by polyent on 16/2/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "UserInfoViewController.h"
#import "HLXApi.h"
#import "AFHTTPSessionManagerTool.h"
#import <MJExtension.h>
#import "UserInfo.h"
#import "ResponseRootObject.h"
#import "UIImage+Util.h"
#import "UIImageView+Util.h"
#import "UIView+Util.h"
#import "CommonDefines.h"
#import "UIColor+Wonderful.h"
#import <MJRefresh.h>
#import "UserInfoTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "CommonDefines.h"

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define headHeight 250
#define headMinH 64
#define tabBarH 44
static NSString* cellId = @"cellId";
@interface UserInfoViewController()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat _navalpha;
}
@property(nonatomic,strong)NSMutableArray* data;
@property(nonatomic,strong)UserInfo* userInfo;
@property (nonatomic,strong) UINavigationBar* navBar;
@property (strong, nonatomic) IBOutlet UIImageView *headBg;
@property (strong, nonatomic) IBOutlet UILabel *fansLabel;
@property (strong, nonatomic) IBOutlet UILabel *noticeLabel;
@property (strong, nonatomic) IBOutlet UILabel *signLabel;
@property (strong, nonatomic) IBOutlet UITableView *contentTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headH;
@property (strong, nonatomic) IBOutlet UIImageView *headIcon;

@property (nonatomic, assign) CGFloat lastOffsetY;

@end
@implementation UserInfoViewController
//-(instancetype)initWithUid:(NSUInteger)uid{
//    self = [super init];
//    if (self) {
//        _uid = uid;
//    }
//    return self;
//}

-(void)viewDidLoad{
    [super viewDidLoad];
     _lastOffsetY = -(headHeight);
    _data = [NSMutableArray new];
    
    NSMutableDictionary* parameters = [AFHTTPSessionManagerTool defaultParameters];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:_uid] forKey:@"uid"];
    [data setObject:params forKey:@"params"];
    [parameters setObject:[data mj_JSONString] forKey:@"data"];
    
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_USER_INFORMATION prefix:HLXAPI_PREFIX parameters:parameters success:^(NSURLSessionDataTask * task, id responseObj) {
        ResponseRootObject* obj = [ResponseRootObject mj_objectWithKeyValues:responseObj];
        if (obj && [obj.ret isEqualToString:@"0"]) {
            _userInfo = [UserInfo mj_objectWithKeyValues:obj.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self initNav];
                [self initHead];
            });
            
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error ) {
        //
    }];
   
    
    NSMutableDictionary* parameters2 = [AFHTTPSessionManagerTool defaultParameters];
    NSMutableDictionary* data2 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* params2 = [[NSMutableDictionary alloc] init];
    [params2 setObject:[NSNumber numberWithInt:_uid] forKey:@"uid"];
    [data2 setObject:params2 forKey:@"params"];
    [parameters2 setObject:[data2 mj_JSONString] forKey:@"data"];

    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_USER_LIST prefix:HLXAPI_PREFIX parameters:parameters2 success:^(NSURLSessionDataTask * task, id responseObj) {
        ResponseRootObject* obj = [ResponseRootObject mj_objectWithKeyValues:responseObj];
        if (obj && [obj.ret isEqualToString:@"0"]) {
            for (id info in obj.data) {
                UserInfoCellModel* model = [UserInfoCellModel mj_objectWithKeyValues:info];
                [_data addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self initTableView];
            });
            
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error ) {
        //
    }];

    
}

-(void)initNav{
  
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [bar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
    bar.layer.masksToBounds = YES;
    
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
    [item setLeftBarButtonItem:back];
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    UILabel* label = [UILabel new];
    label.frame = CGRectMake(0, 0, 80, 44);
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    label.text = _userInfo.username;
    [titleView addSubview:label];
    
    UIImageView* genderView = [UIImageView new];
    genderView.frame =  CGRectMake(CGRectGetMaxX(label.frame)+2, CGRectGetMaxY(label.frame) - 35, 20 , 20);
    
    if (_userInfo.gender == 0) {
        genderView.image = [UIImage imageNamed:@"userinfo_gender_female"];
        
    }else{
        genderView.image = [UIImage imageNamed:@"userinfo_gender_male"];
    }
    [titleView addSubview:genderView];
    
    [item setTitleView:titleView];
    
    [bar pushNavigationItem:item animated:NO];
    [self.view bringSubviewToFront:bar];
    _navBar = bar;
    [self.view addSubview:bar];

    
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)initHead{
//    [_headBg setCornerRadius:_headBg.frame.size.width/2];
    NSLog(@"%@",[NSString stringWithFormat:@"bg_%u",_userInfo.cover]);
    _headBg.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%u",_userInfo.cover]];
    [_headIcon loadPortraitWithNSString:_userInfo.avatar];
    [_headIcon setCornerRadius:_headIcon.frame.size.width/2];
    _fansLabel.text = [NSString stringWithFormat:@"粉丝 %@",_userInfo.fans];
    _noticeLabel.text = [NSString stringWithFormat:@"关注 %@",_userInfo.follows];
    _signLabel.text = _userInfo.sign;
}

-(void)initTableView{
    [self.contentTableView registerClass:[UserInfoTableViewCell class] forCellReuseIdentifier:cellId];

    self.contentTableView.contentInset = UIEdgeInsetsMake(headHeight , 0, 0, 0);
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat delta = offsetY - _lastOffsetY;
    
    // 往上拖动，高度减少。
    CGFloat height = headHeight - delta;
    
    if (height < headMinH) {
        height = headMinH;
    }
    NSLog(@"%f",height);
    _headH.constant = height;
    
    // 设置导航条的背景图片
    CGFloat alpha = delta / (headHeight);
    NSLog(@"delta%f",delta);
    // 当alpha大于1，导航条半透明，因此做处理，大于1，就直接=0.99
    if (alpha >= 1) {
        [_navBar setBarTintColor:[UIColor deepSkyBlue]];
    }else{
        _navBar.backgroundColor = [UIColor clearColor];
    }
//    _navalpha = alpha;
//    _navBar.alpha = alpha;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    [cell setModel:_data[indexPath.row]];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//        UITableView* view = [UITableView new]
//        CGFloat h = [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
    UserInfoCellModel* model = _data[indexPath.row];
        return [self.contentTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[UserInfoTableViewCell class] contentViewWidth:[self cellContentViewWith]];


}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
@end
