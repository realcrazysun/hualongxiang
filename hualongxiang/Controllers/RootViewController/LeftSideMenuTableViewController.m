//
//  LeftSideMenuTableViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/9.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "LeftSideMenuTableViewController.h"
#import "UIColor+Wonderful.h"
#import "CommonDefines.h"
#import "UIView+Util.h"
#import "AFHTTPSessionManagerTool.h"
#import "HLXApi.h"
#import "MJExtension.h"
#import "User.h"
#import "ResponseRootObject.h"
#import "Config.h"
#import "UIImageView+Util.h"
#import "SettingPage.h"
#import <RESideMenu.h>
#import "LoginViewController.h"
#define TopViewWidth (ScreenWidth*2/3 - 10)
@interface LeftSideMenuTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet TopView *topView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (strong, nonatomic) IBOutlet UIButton *setBtn;

@end

@implementation LeftSideMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = [UIColor maroonColor];
    //注册用户信息修改变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"userRefresh" object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //背景色设置
    self.view.backgroundColor = [UIColor darkSlateGray];
    self.topView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.bottomView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.setBtn setCornerRadius:3];
    [self.setBtn setBorderWidth:1 andColor:[UIColor grayColor]];
    [self.setBtn addTarget:self action:@selector(clickSetBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self initTopView];
    UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doLogin)];
    [self.topView addGestureRecognizer:recognizer];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initTopView) name:@"topViewRefresh" object:nil];
}

-(void)clickSetBtn{
    SettingPage* settingPage = [[SettingPage alloc] init];
    [self.sideMenuViewController hideMenuViewController];

    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:settingPage];
    [self presentViewController:nav  animated:NO completion:nil];
//    [self setContentViewController:settingPage];
}


- (void)reload
{
#pragma mark --  为何要用gcd
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initTopView];
        [self.tableView reloadData];
    });
}


- (void)dealloc
{
    //important 注册通知消息在dealloc时移除掉
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initTopView{
    
    User *myProfile = [Config myProfile];
    if (myProfile) {
        self.topViewHeight.constant = 150;
    }else {
         self.topViewHeight.constant = 100;
    }
    
    [self.topView initSubViews:myProfile];
}

-(void)doLogin{
    LoginViewController* vc = [[LoginViewController alloc] init];
    [self.sideMenuViewController hideMenuViewController];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav  animated:NO completion:nil];
//    [self.navigationController presentViewController:nav animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:@[@"icon_fans", @"icon_following", @"icon_local_circle", @"icon_forum", @"icon_collect", @"icon_private_msg"][indexPath.row]];
    cell.textLabel.text = @[@"粉丝", @"关注", @"巷友圈", @"帖子", @"收藏", @"私信"][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:19];
    cell.textLabel.textColor = [UIColor lightTextColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}
//点击登录
- (void)pushLoginPage
{
//    if ([Config getOwnID] == 0) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//        [self setContentViewController:loginVC];
//    } else {
//        return;
//    }
}

- (void)setContentViewController:(UIViewController *)viewController
{
//    viewController.hidesBottomBarWhenPushed = YES;
//    UINavigationController *nav = (UINavigationController *)((UITabBarController *)self.sideMenuViewController.contentViewController).selectedViewController;
//    UIViewController *vc = nav.viewControllers[0];
//    vc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    nav.navigationItem.titleView = nil;
//    [nav pushViewController:viewController animated:YES];
    
//    [self.sideMenuViewController hideMenuViewController];
}

@end

@interface TopView ()
{
    UIImageView* _iconView;
    UILabel* _nameLabel;
    UILabel* _signature;
    
}

@end
@implementation TopView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

-(void)initSubViews:(User*)userData{
    for (UIView* view in self.subviews) {
        [view  removeFromSuperview];
    }
   
    UIView* view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TopViewWidth, 100)];
    view1.backgroundColor = [UIColor clearColor];
    [self addSubview:view1];
    
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 60, 60)];
    _iconView.image = [UIImage imageNamed:@"ic_default_icon"];
    [_iconView setCornerRadius:_iconView.frame.size.width/2];
    [view1 addSubview:_iconView];
    CGFloat namelabelX = CGRectGetMaxX(_iconView.frame)+5;
    CGFloat namelabelY = CGRectGetMinY(_iconView.frame)+5;
    CGFloat width = TopViewWidth - namelabelX - 20;
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(namelabelX, namelabelY, width, 20)];
    _nameLabel.text = @"点击登录";
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    
    _signature = [[UILabel alloc] initWithFrame:CGRectMake(namelabelX, namelabelY+25, width, 20)];
    _signature.text = @"点击查看更多";
    _signature.font = [UIFont systemFontOfSize:14];
    _signature.textColor = [UIColor lightTextColor];
    [self addSubview:_signature];
    
    UILabel* label = [UILabel new];
    label.frame = CGRectMake(TopViewWidth-15, CGRectGetMinY(_signature.frame)-5, 10, 10);
    label.text = @">";
    label.textColor = [UIColor lightTextColor];
    [self addSubview:label];
    
    if (userData) {
        UIView* view2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), TopViewWidth, 50)];
         [self addSubview:view2];
        
        UILabel* weiwangnumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TopViewWidth/4, 15)];
        weiwangnumLabel.textAlignment = NSTextAlignmentCenter;
        weiwangnumLabel.textColor = [UIColor lightTextColor];
        [view2 addSubview:weiwangnumLabel];
        
        UILabel* weiwang = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, TopViewWidth/4, 15)];
        weiwang.text = @"威望";
        weiwang.textAlignment = NSTextAlignmentCenter;
        weiwang.textColor = [UIColor lightTextColor];
        [view2 addSubview:weiwang];
        
        UILabel* goldnumLabel = [[UILabel alloc] initWithFrame:CGRectMake(TopViewWidth/4, 0, TopViewWidth/4, 15)];
        goldnumLabel.textAlignment = NSTextAlignmentCenter;
        goldnumLabel.textColor = [UIColor lightTextColor];
        [view2 addSubview:goldnumLabel];
        
        UILabel* goldLabel = [[UILabel alloc] initWithFrame:CGRectMake(TopViewWidth/4, 25, TopViewWidth/4, 15)];
        goldLabel.text = @"金币";
        goldLabel.textAlignment = NSTextAlignmentCenter;
        goldLabel.textColor = [UIColor lightTextColor];
        [view2 addSubview:goldLabel];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(TopViewWidth/2+10, 10, 80, 30);
        [button setTitle:@"摇一摇" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor aquamarine]];
        [button setCornerRadius:4];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [view2 addSubview:button];
        
        _nameLabel.text = userData.username;
        [_iconView loadPortraitWithNSString:userData.faceurl];
        weiwangnumLabel.text = [NSString stringWithFormat:@"%d",userData.rvrc];
        goldnumLabel.text = [NSString stringWithFormat:@"%d",userData.money];
        _signature.text = userData.sign;
    }
}
@end