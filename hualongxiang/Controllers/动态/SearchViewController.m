//
//  SearchViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/22.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "SearchViewController.h"
#import "UIView+Util.h"
#import "UIColor+Wonderful.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "QF.h"
#import "Config.h"
#import "Utils.h"
#import <MBProgressHUD.h>
#import "HLXApi.h"
#import "NSString+URL.h"
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSMutableArray* history;//查询历史记录
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) UIWebView*   webView;
@property (nonatomic,assign) SearchViewControllerState state;
@property (nonatomic,strong) MBProgressHUD *HUD;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _history = [NSMutableArray new];
    _state = Idle;
    _HUD = [Utils createHUD];
    _HUD.hidden = YES;
    [self loadHistory];
    [self initNavigationBar];
    [self initTableView];
    [self initWebView];
}

- (void)initNavigationBar{
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _searchBar = [UISearchBar new];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入关键字";
    _searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width-100, 44);
    [_searchBar becomeFirstResponder];
    UIBarButtonItem* left = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
    [item setLeftBarButtonItem:left];
    
    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame), 0, 50, 44)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    [item setRightBarButtonItem:right];
#pragma mark -- 修改导航栏颜色失败  自定义导航栏 issue frame && color
    //    [bar setTintColor:[UIColor clearColor]];
    //    [bar setBackgroundColor:[UIColor clearColor]];
    [bar pushNavigationItem:item animated:NO];
    //    [right setTintColor:[UIColor clearColor]];
    [self.view addSubview:bar];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)loadHistory{
    [_history removeAllObjects];
    NSMutableArray* array = [Config loadSearchHistory];
    if (array) {
        [_history addObjectsFromArray:array];
    }
    
}

/**
 *初始化tableView
 */
-(void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(void)initWebView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}
- (void)showResult:(NSString*)text saveHistory:(BOOL)saveHistory{
    //移除searchBar 键盘
    [_searchBar resignFirstResponder];
    //切换显示状态
    _state = Search;
    //TODO 记录当前历史记录
    if (saveHistory) {
          [Config addSearchHistory:_searchBar.text];
    }
    //加载动画
    _HUD.hidden = NO;
//    [_HUD show:YES];
    [_HUD hide:YES afterDelay:5];

    _tableView.hidden = YES;
    _webView.hidden = NO;
    NSString* urlString =[NSString stringWithFormat:@"%@%@",HLXAPI_SEARCH,[text URLEncodedString]] ;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [_webView loadRequest:request];
}
/**
 *  点击取消按钮
 */
- (void)clickCancelBtn{
    switch (_state) {
        case Idle:{
            [_searchBar resignFirstResponder];
            [self.navigationController popViewControllerAnimated:YES ];
            break;
        }
        case Search:{
            _webView.hidden = YES;
            _tableView.hidden = NO;
            [self loadHistory];
            [_tableView reloadData];
            _state = Idle;
        }
        default:
            break;
    }
    
}

#pragma mark -- SearchBar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    _state = Idle;
    _tableView.hidden = NO;
    _webView.hidden = YES;
    _HUD.hidden = YES;
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self showResult:_searchBar.text saveHistory:YES];
}

/**
 *  清空搜索历史
 */
-(void)clearHistory{
    [Config clearSearchHistory];
    [self loadHistory];
    [self.tableView reloadData];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _history.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _history[indexPath.row];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor clearColor];
    UIButton* clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
    [clearBtn setTitle:@"清除历史记录" forState:UIControlStateNormal];
    clearBtn.center = view.center;
    [clearBtn setCornerRadius:4];
    [clearBtn setBorderWidth:1 andColor:[UIColor deepSkyBlue]];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [clearBtn setTitleColor:[UIColor deepSkyBlue] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:clearBtn];
    return view;
}
#pragma mark -- tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //TODO  加载历史搜索记录
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString* text = cell.textLabel.text;
    [self showResult:text saveHistory:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_history removeObjectAtIndex:indexPath.row];
        
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}
#pragma mark --webViewdelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"----");
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    QF* qf = [[QF alloc] init];
    context[@"QF"] = qf;
    qf.fromVC = self;
    _HUD.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error{
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
    _HUD.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
    [_HUD hide:YES afterDelay:1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
