//
//  PhotoViewController.m
//  新闻
//
//  Created by gyh on 15/9/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PhotoViewController.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "PhotoCell.h"
#import "HMWaterflowLayout.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "PhotoShowViewController.h"
#import "UIBarButtonItem+gyh.h"
#import "DOPNavbarMenu.h"
#import "UIColor+Wonderful.h"
#import "CommonDefines.h"
#import "AFHTTPSessionManagerTool.h"
#import "HLXApi.h"
#import "ResponseRootObject.h"
#import "Utils.h"
#import <MBProgressHUD.h>
#import "HotRecommend.h"
#import "WEPopoverViewController.h"
#import "WEPopoverContentViewController.h"
#import <WEPopoverController.h>
@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HMWaterflowLayoutDelegate>
@property(nonatomic,assign) int pageNum;
@property (nonatomic , weak)    UICollectionView *collectionView;
@property (nonatomic , strong)  NSMutableArray *photoArray;
@property (nonatomic , assign)  PhotoType type;
@property (nonatomic , strong)  WEPopoverController * popoverController;
@property (nonatomic , strong)  UIButton* titleBtn;//标题栏按钮

//@property (nonatomic , assign) int pn;
//@property (nonatomic , copy) NSString *tag1;
//@property (nonatomic , copy) NSString *tag2;
//@property (nonatomic , assign) NSInteger numberOfItemsInRow;


@end

@implementation PhotoViewController

static NSString *const ID = @"photo";

-(NSMutableArray *)photoArray
{
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _type = PhotoTypeDay;
    [self initNavigationBar];
    

    [self initCollection];
    [self setupRefreshView];
    //
    //     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mynotification) name:self.title object:nil];
    
}

- (void)initNavigationBar{
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [bar setBarTintColor:[UIColor deepSkyBlue]];
    
    UIBarButtonItem* back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
    [item setLeftBarButtonItem:back];
    
    UIBarButtonItem* photo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_pai_photo"] style:UIBarButtonItemStylePlain target:self action:@selector(clickPhoto)];
    [item setRightBarButtonItem:photo];
    
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleBtn setTitle:[NSString stringWithFormat:@"%@ ▿" ,itemArr[_type]] forState:UIControlStateNormal];
    [_titleBtn addTarget:self action:@selector(showPopover:) forControlEvents:UIControlEventTouchUpInside];
    [item setTitleView:_titleBtn];
    
    [bar pushNavigationItem:item animated:NO];
    [self.view bringSubviewToFront:bar];
    
    [self.view addSubview:bar];
    
}

- (void) showPopover:(UIButton*)sender {
    
    if (!self.popoverController) {
        
        WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain currentType:_type];
        typeof(self) __weak weakself = self;
        contentViewController.clickItem = ^(NSString* item){
            [weakself.titleBtn setTitle: [NSString stringWithFormat:@"%@ ▿" ,item] forState:UIControlStateNormal];
            weakself.type = [itemArr indexOfObject:item];
            [weakself.collectionView.mj_header beginRefreshing];
            [weakself.popoverController dismissPopoverAnimated:YES];
            weakself.popoverController = nil;
        };
        self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
        self.popoverController.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
//        self.popoverController.delegate = self;
        
        [self.popoverController setContainerViewProperties:[self improvedContainerViewProperties]];
        CGRect rect = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+10, sender.frame.size.width, sender.frame.size.height);
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

-(void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickPhoto{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


-(void)mynotification
{
    //    [self.collectionView.header beginRefreshing];
}

-(void)initCollection
{
    
    HMWaterflowLayout *layout = [[HMWaterflowLayout alloc]init];
    layout.columnsCount = 2;
    layout.delegate = self;
    
    // 2.创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
}



//集成刷新控件
-(void)setupRefreshView
{
    //1.下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.mj_header beginRefreshing];
    //2.上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
#pragma mark  下拉
-(void)loadNewData
{
    [self fetchObjects:1 refresh:YES];
}
#pragma mark  上拉
-(void)loadMoreData
{
    [self fetchObjects:++_pageNum refresh:NO];
}

-(NSArray*)parse:(ResponseRootObject*)response{
    //分两种情况  一种为模型  模型参数名不确定  在之类实现  一种为模型数组
    
    NSArray* arr = response.data;
    NSMutableArray* array = [NSMutableArray new];
    for (int i = 0; i < arr.count; i++) {
        id model = [HotRecommend mj_objectWithKeyValues:arr[i]];
        [array addObject:model];
    }
    return array;
    
}

-(void)fetchObjects:(NSUInteger)page refresh:(BOOL)refresh
{
    NSMutableDictionary* parameters = [AFHTTPSessionManagerTool defaultParameters];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
        [params setObject:[NSNumber numberWithInt:_type] forKey:@"type"];
        [data setObject:params forKey:@"params"];
        [parameters setObject:[data mj_JSONString] forKey:@"data"];

    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_SIDE_HOT_LIST
                                    prefix:HLXAPI_PREFIX
                                parameters:parameters
                                   success:^(NSURLSessionDataTask * task, id responseObject) {
                                       ResponseRootObject* obj = [ResponseRootObject mj_objectWithKeyValues:responseObject];
                                       if (![obj.ret isEqualToString:@"0"]) {
                                           NSLog(@"数据异常----");
                                           return ;
                                       }
                                       
                                       if (refresh) {
                                           _pageNum = 1;
                                           [self.photoArray removeAllObjects];//如果加载第0页则会清空当前_objects
                                       }
                                       
                                       int beforeCount = (int)[self.photoArray count];
                                       NSArray* array = [self parse:obj];
                                       for (id object in array) {
                                           [self.photoArray addObject:object];
                                       }
                                       
                                       int addCount = (int)[self.photoArray count] - beforeCount;
                                    
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                         
                                           if (addCount == 0){
                                               [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                                           }
                                           if (self.collectionView.mj_header.isRefreshing) {
                                               [self.collectionView.mj_header endRefreshing];
                                           }
                                           if(self.collectionView.mj_footer.isRefreshing){
                                               [self.collectionView.mj_footer endRefreshing];
                                           }
                                           [self.collectionView reloadData];
                                       });
                                       
                                       
                                   } failure:^(NSURLSessionDataTask * task, NSError * error) {
                                       MBProgressHUD *HUD = [Utils createHUD];
                                       HUD.mode = MBProgressHUDModeCustomView;
                                       HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                                       HUD.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                                       [HUD hide:YES afterDelay:1];
                                       
                                   }];
}

#pragma mark 加载更多数据
-(void)NetWorking
{
    //    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc]init];
    //    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    //    dic[@"pn"] = [NSString stringWithFormat:@"%d",self.pn];
    //    dic[@"rn"] = @60;
    //
    //    NSString *urlstr = [NSString stringWithFormat:@"http://image.baidu.com/wisebrowse/data?tag1=%@&tag2=%@",self.tag1,self.tag2];
    //    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    [mgr GET:urlstr parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject){
    //
    //        NSArray *dataarray = [Photo objectArrayWithKeyValuesArray:responseObject[@"imgs"]];
    //        // 创建frame模型对象
    //        NSMutableArray *statusFrameArray = [NSMutableArray array];
    //        for (Photo *photo in dataarray) {
    //            [statusFrameArray addObject:photo];
    //        }
    //
    //        [self.photoArray addObjectsFromArray:statusFrameArray];
    //
    //        self.pn += 60;
    //
    //        // 刷新表格
    //        [self.collectionView reloadData];
    //
    //        [self.collectionView.footer endRefreshing];
    //
    //    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
    //
    //    }];
}


#pragma mark - <HMWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(HMWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    HotRecommend *photo = self.photoArray[indexPath.item];
    NSDictionary* dic = photo.cover;
    //判断width为0
    if ([(NSString*)[dic objectForKey:@"width"] intValue] == 0) {
        return 0;
    }
    return [(NSString*)[dic objectForKey:@"height"] floatValue]/ [(NSString*)[dic objectForKey:@"width"] floatValue] * width;
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.photo = self.photoArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    PhotoShowViewController *photoShow = [[PhotoShowViewController alloc]init];
//    photoShow.currentIndex = (int)indexPath.row;
//    photoShow.mutaArray = self.photoArray;
//    [self.navigationController pushViewController:photoShow animated:YES];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    self.menu = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    if (self.menu) {
//        [self.menu dismissWithAnimation:NO];
//    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:self.title object:nil];
    [self.navigationController setNavigationBarHidden:NO];
}



@end
