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
#import "SearchViewController.h"
#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"
#import "HotThread.h"
#import "DynamicInfoCellOnePic.h"
#import "DynamicInfoCellThreePic.h"
#import "CellWithNoPicTableViewCell.h"

static NSString* reuseIdentifier = @"cellOne";
static NSString* reuseIdentifier2 = @"cellThree";
static NSString* reuseIdentifier3 = @"cellNOPic";

#define itemArr  @[@"24小时热点 ",@"最新发布",@"最后回复"]
#define typeArr  @[@"hits",@"postdate",@"lastpost "]
@interface CommunityViewController ()<UIScrollViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)CommunityHeaderView* head;

@property (nonatomic , strong)  WEPopoverController * popoverController;
@property (nonatomic , assign)  PhotoType type;
@end

@implementation CommunityViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(){
            return [NSString stringWithFormat:@"%@", HLXAPI_FORUM_GETHOTTHREADS];
        };
        self.objClass = [HotThread class];
        _type = TwentyFourHour;
        typeof(self) __weak weakself = self;
        self.generateParams = ^(NSUInteger page){
            NSMutableDictionary* parameters = [AFHTTPSessionManagerTool defaultParameters];
            NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
            [params setObject:typeArr[weakself.type] forKey:@"order"];
            [data setObject:params forKey:@"params"];
            [parameters setObject:[data mj_JSONString] forKey:@"data"];
            return parameters;
        };
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //    self.tableView.rowHeight = 140;
    //      UINib* nib = [UINib nibWithNibName:NSStringFromClass([ActivityInfoTableViewCell class]) bundle:nil];
    //    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    
    [self.tableView registerClass:[DynamicInfoCellOnePic class] forCellReuseIdentifier:reuseIdentifier];
    [self.tableView registerClass:[DynamicInfoCellThreePic class] forCellReuseIdentifier:reuseIdentifier2];
    [self.tableView registerClass:[CellWithNoPicTableViewCell class] forCellReuseIdentifier:reuseIdentifier3];
    
    [self initNav];
    
#warning 要用tableHeaderView 而不能用viewForHeaderInSection  否则无法响应点击事件
#warning CommunityHeaderView 直接设置为tableHeaderView会出现诡异情况 。。nnd
    
    CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, 300);
    UIView* view = [[UIView alloc] initWithFrame:frame];
    _head  = [[[NSBundle mainBundle]loadNibNamed:@"CommunityHeaderView" owner:nil options:nil] firstObject];
    _head.frame = frame;
    [view addSubview:_head];
    _head.scrollView.delegate = self;
    _head.searchBar.delegate = self;
    [_head.chooseBtn addTarget:self action:@selector(showPopover:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = view ;
}

/**
 *  初始化导航栏
 *
 *  @return
 */
-(void)initNav{
    
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
    NSMutableDictionary* dic = [AFHTTPSessionManagerTool defaultParameters];
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_JUHEBANKUAI
                                    prefix:HLXAPI_PREFIX
                                parameters:dic
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
    
    HotThread* object = self.objects[indexPath.row];
    if(object.imgs.count == 0){
        CellWithNoPicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier3];
        [cell setData:object.subject name:object.author readCount:object.replies time:object.postdate];
        return cell;
        
    }else if(object.imgs.count < 3){
        DynamicInfoCellOnePic* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        cell.titleLabel.text        = object.subject;
        cell.nameLabel.text         = object.author;
        cell.readcountLabel.text    = object.replies;
        [cell setImgUrl:[object.imgs[0] objectForKey:@"attachurl"]];
        return cell;
        
    }else{
        DynamicInfoCellThreePic* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
        cell.titleLabel.text        = object.subject;
        cell.nameLabel.text         = object.author;
        cell.readcountLabel.text    = object.replies;
        cell.timeLabel.text         = object.postdate;
        NSMutableArray* arr = [NSMutableArray new];
        for (int i = 0 ; i < 3; i++) {
            [arr addObject:[object.imgs[i] objectForKey:@"attachurl"]];
        }
        [cell setImgArr:[arr copy]];
        return cell;
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HotThread* object = self.objects[indexPath.row];
    if(object.imgs.count == 0){
        
        return 90;
        
    }else if(object.imgs.count < 3){
        return 100;
        
    }else{
        DynamicInfoCellThreePic* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
        cell.titleLabel.text        = object.subject;
        cell.nameLabel.text         = object.author;
        cell.readcountLabel.text    = object.replies;
        cell.timeLabel.text         = object.postdate;
        NSMutableArray* arr = [NSMutableArray new];
        for (int i = 0 ; i < 3; i++) {
            [arr addObject:[object.imgs[i] objectForKey:@"attachurl"]];
        }
        [cell setImgArr:[arr copy]];
        return 160;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

#pragma mark--scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    _head.pageControl.currentPage = (_head.scrollView.contentOffset.x/_head.scrollView.frame.size.width);
}

#pragma mark -- searchBar delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController *vc = [SearchViewController new];
    [self.navigationController pushViewController:vc animated:NO];
    return NO;
}

- (void) showPopover:(UIButton*)sender {
    
    if (!self.popoverController) {
        
        WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain currentType:_type typeArray:itemArr];
        
        contentViewController.preferredContentSize = CGSizeMake(sender.frame.size.width, (itemArr.count-1) * 40 - 1);
        
        typeof(self) __weak weakself = self;
        contentViewController.clickItem = ^(NSString* item){
            [weakself.head.chooseBtn setTitle: [NSString stringWithFormat:@"%@ ▿" ,item] forState:UIControlStateNormal];
            weakself.type = [itemArr indexOfObject:item];
            //            [weakself.collectionView.mj_header beginRefreshing];
            
            [weakself.popoverController dismissPopoverAnimated:YES];
            weakself.popoverController = nil;
            [weakself.tableView.mj_header beginRefreshing];
        };
        self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
        self.popoverController.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        //        self.popoverController.delegate = self;
        
        [self.popoverController setContainerViewProperties:[self improvedContainerViewProperties]];
        
        //需要做一下坐标转换
        CGRect conrect = [self.view convertRect:_head.chooseBtn.frame fromView:_head.chooseBtn.superview];
        
        CGRect rect = CGRectMake(conrect.origin.x, conrect.origin.y-5, conrect.size.width, conrect.size.height);
        
        [self.popoverController presentPopoverFromRect:rect
                                                inView:self.view
                              permittedArrowDirections:(UIPopoverArrowDirectionUp)
                                              animated:YES];
        
        
        
    } else {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
}

- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
    
    WEPopoverContainerViewProperties *props = [[WEPopoverContainerViewProperties alloc] init];
    NSString *bgImageName = nil;
    CGFloat bgMargin = 0.0;
    CGFloat bgCapSize = 0.0;
    CGFloat contentMargin = 0;
    
    bgImageName = @"popoverBg.png";
    
    props.backgroundMargins = UIEdgeInsetsMake(bgMargin, bgMargin, bgMargin, bgMargin);
    props.leftBgCapSize = bgCapSize;
    props.topBgCapSize = bgCapSize;
    props.bgImageName = bgImageName;
    
    props.contentMargins = UIEdgeInsetsMake(contentMargin, contentMargin, contentMargin, contentMargin);
    
    props.arrowMargin = 0;
    
    props.upArrowImageName = @"popoverArrowUp.png";
    props.downArrowImageName = @"popoverArrowDown.png";
    props.leftArrowImageName = @"popoverArrowLeft.png";
    props.rightArrowImageName = @"popoverArrowRight.png";
    props.maskBorderWidth = 0;
    return props;
}

@end

