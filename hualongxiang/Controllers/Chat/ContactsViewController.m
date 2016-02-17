//
//  ContactsViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/25.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "ContactsViewController.h"
#import "UIColor+Wonderful.h"
#import "ContactTableViewCell.h"
#import "AFHTTPSessionManagerTool.h"
#import "HLXApi.h"
#import "ResponseRootObject.h"
#import "Contact.h"
@interface ContactsViewController()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate, UISearchControllerDelegate,UISearchResultsUpdating>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchController *searchController;
@property (strong,nonatomic) NSArray  *fixedList;
@property (strong,nonatomic) NSArray  *dataList;
@property (strong,nonatomic) NSMutableArray  *dataForSearchList;
@property (strong,nonatomic) NSMutableArray  *searchList;
@end
@implementation ContactsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteSmoke];
    _searchList = [NSMutableArray new];
    _dataForSearchList = [NSMutableArray new];
    [self initNav];
    NSMutableDictionary* parameters = [AFHTTPSessionManagerTool defaultParameters];
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_USER_FOLLOWERS prefix:HLXAPI_PREFIX parameters:parameters success:^(NSURLSessionDataTask * task , id responseObj) {
        //
        ResponseRootObject* model = [ResponseRootObject mj_objectWithKeyValues:responseObj];
        if ([model.ret isEqualToString:@"0"]) {
            Contact* contact = [Contact mj_objectWithKeyValues:model.data];
            _fixedList = contact.fixed;
            _dataList  = contact.list;
//            for (id obj in _fixedList) {
//                [_dataForSearchList addObject:obj];
//            }
            for (DyContactList* list in _dataList) {
                for (DyContact* contact in list.list) {
                    [_dataForSearchList addObject:contact];
                }
            }
            [self initTableView];
            [self initSearchController];
        }
        else{
            //TODO  验证失败  跳转到登陆页面
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        //处理没有网络
        NSLog(@"网络失败");
    }];
    
    
}
-(void)onClickleftMenuButton{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initNav{
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_arrow_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(onClickleftMenuButton)];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"选 择 联 系 人";
    self.navigationItem.titleView = title;
}

-(void)initSearchController{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

-(void)initTableView{
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64 );
    _tableView.sectionIndexColor = [UIColor blackColor];
    [self.view addSubview:_tableView];
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.nickname CONTAINS[cd] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //   ' 过滤数据
    NSArray* arr = [_dataForSearchList filteredArrayUsingPredicate:preicate];
    
    self.searchList= [NSMutableArray arrayWithArray:arr];
    //刷新表格
    
    
    [self.tableView reloadData];
}

#pragma mark -- tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_searchController.active) {
        return 1;
    }else{
        return 1+_dataList.count;
    }
}

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchController.active) {
        return [self.searchList count];
    }else{
        if (section == 0) {
            return _fixedList.count;
        }
        DyContactList* dylist = _dataList[section - 1];
        return dylist.list.count;
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellFlag";
    ContactTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (_searchController.active) {
        [cell setData:_searchList[indexPath.row]];
    }
    else{
        if (indexPath.section == 0) {
            FixedContact* contact = _fixedList[indexPath.row];
            [cell setData:contact];
        }else{
            DyContactList* dyList = _dataList[indexPath.section - 1];
            DyContact* contact = dyList.list[indexPath.row];
            [cell setData:contact];
        }
    }
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section>0) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        view.backgroundColor = [UIColor lightGrayColor];
        view.alpha = 0.5;
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-20, 30)];
        label.text = ((DyContactList*)_dataList[section-1]).letter;
        [view addSubview:label];
        return view;
    }
    return nil;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray* array = [NSMutableArray new];
    NSArray* list = _dataList;
    for ( DyContactList* dyList in list) {
        [array addObject:dyList.letter];
    }
    return array;
}
#pragma mark -- tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_searchController.active) {
        return 0;
    }else{
        if(section == 0){
            return 0;
        }else{
            return 30;
        }
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{
    
    
    //点击索引，列表跳转到对应索引的行
    
    [tableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index+1]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];

    
    return index+1;
    
}
#pragma mark -- searchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
@end
