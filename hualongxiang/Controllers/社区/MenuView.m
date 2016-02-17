//
//  MenuView.m
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "MenuView.h"
#import "CommonDefines.h"
#import "MenuViewLeftTabelViewCell.h"
#import "Forum.h"
#import "UIImageView+Util.h"
#import "UIView+Util.h"
#import "RightMenuCell.h"
#import "AFHTTPSessionManagerTool.h"
#import "MJExtension.h"
#import "HLXApi.h"
#import "ResponseRootObject.h"
#define kLeftWidth 100
#define NOMORE_DES @"没有更多数据"
@interface MenuView()
@property(nonatomic,strong) UITableView* leftTableView;
@property(nonatomic,strong) UITableView* rightTableView;
@property(nonatomic,assign,readonly) NSInteger selectIndex;
//@property(nonatomic,assign)NSInteger rightTableViewCurPage;
@property(nonatomic,strong)NSMutableDictionary* rightTableViewCurPageDic;
@end
@implementation MenuView

-(instancetype)initWithFrame:(CGRect)frame WithData:(NSArray*)data {
    if (self  == [super initWithFrame:frame]) {
        if (data.count == 0) {
            return nil;
        }
        _selectIndex=0;
        _rightTableViewCurPageDic = [NSMutableDictionary new];
        [_rightTableViewCurPageDic setObject:@(0) forKey:@(_selectIndex)];
        _data = data;
        [self initLeftTableView];
        [self initRightTableView];
    }
    return self;
}

-(void)initLeftTableView{
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, self.frame.size.height)];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.backgroundColor = LeftBgColor;
    _leftTableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:_leftTableView];
    
    //分割线15像素空白
    if ([_leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _leftTableView.layoutMargins = UIEdgeInsetsZero;
    }
    if ([_leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _leftTableView.separatorInset = UIEdgeInsetsZero;
    }
    _leftTableView.separatorColor = LeftSeparatorColor;
    
}

-(void)initRightTableView{
    
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftWidth, 0, self.frame.size.width - kLeftWidth, self.frame.size.height)];
    _rightTableView.dataSource = self;
    _rightTableView.delegate = self;
    //  _rightTableView.backgroundColor = [UIColor redColor];
    _rightTableView.backgroundColor = LeftSelectBgColor;
    _rightTableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:_rightTableView];
    
    //分割线15像素空白
    if ([_rightTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _rightTableView.layoutMargins = UIEdgeInsetsZero;
    }
    if ([_rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        _rightTableView.separatorInset = UIEdgeInsetsZero;
    }
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


-(void)reloadData{
    [_leftTableView reloadData];
    [_rightTableView reloadData];
}
#pragma mark---datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:_leftTableView]) {
        return 1;
    }else if ([tableView isEqual:_rightTableView]){
        return 1;
    }
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_leftTableView]) {
        return _data.count;
    }else if ([tableView isEqual:_rightTableView]){
        if (_selectIndex>=0 && _selectIndex < _data.count) {
            Forum* forum =  _data[_selectIndex];
            return forum.subforum.count;
        }
        return 0;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTableView]) {
        static NSString * Identifier=@"leftCell";
        MenuViewLeftTabelViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
        
        if (!cell) {
            cell=[[MenuViewLeftTabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier ];
            
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        Forum* forum = _data[indexPath.row];
        [cell setTitle:forum.name];
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins=UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset=UIEdgeInsetsZero;
        }
        
        if (indexPath.row==self.selectIndex) {
            [cell clicked];
        }
        else{
            [cell reset];
            
        }
        return cell;
    }else if ([tableView isEqual:_rightTableView]){
        static NSString * rightIdentifier=@"rightCell";
        RightMenuCell * cell=[tableView dequeueReusableCellWithIdentifier:rightIdentifier];
        if (!cell) {
            cell=[[RightMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightIdentifier ];
            
        }
        Forum * forum = _data[_selectIndex];
        NSArray* subforums = forum.subforum;
        Subforum* subforum = subforums[indexPath.row];
        [cell setData:subforum];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark -- delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    CGFloat sectionHeaderHeight = 30;//设置你footer高度
//
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//
//    }
//
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTableView]) {
        return 44;
    }else {
        return 60;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_leftTableView]) {
        if (_selectIndex !=  indexPath.row ) {
            _selectIndex = indexPath.row;
            if (![_rightTableViewCurPageDic objectForKey:@(_selectIndex)]) {
                [_rightTableViewCurPageDic setObject:@(0) forKey:@(_selectIndex)];
            }
            [self reloadData];
        }
    }else if ([tableView isEqual:_rightTableView]){
        Forum * forum = _data[_selectIndex];
        NSArray* subforums = forum.subforum;
        Subforum* subforum = subforums[indexPath.row];
        if (self.choose) {
            self.choose(subforum);
        }
        if (self.dismissVC) {
            self.dismissVC();
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:_rightTableView]) {
        Forum* forum = _data[_selectIndex];
        if (forum.showextra) {
            return 30;
        }
    }
    return 0;
}
- ( UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:_rightTableView]) {
        Forum* forum = _data[_selectIndex];
        if (forum.showextra) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
            view.backgroundColor = [UIColor clearColor];
            UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            [btn setTitle:@"点击加载更多" forState:UIControlStateNormal];
            btn.center = view.center;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            return view;
            
        }
    }
    return nil;
}

-(void)loadMore:(UIButton*) btn{
    if ([btn.titleLabel.text isEqualToString:NOMORE_DES]) {
        return;
    }
    NSMutableDictionary * parameters = [AFHTTPSessionManagerTool defaultParameters];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    Forum* forum = _data[_selectIndex];
    [params setObject:[NSNumber numberWithInteger:forum.fid]forKey:@"fid"];
    
    NSNumber *number = [_rightTableViewCurPageDic objectForKey:@(_selectIndex)];
    [params setObject:[NSNumber numberWithInteger:[number intValue] +1] forKey:@"page"];
    [data setObject:params forKey:@"params"];
    [parameters setObject:[data mj_JSONString] forKey:@"data"];
    
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_GET_SUBFORUMS prefix:HLXAPI_PREFIX parameters:parameters success:^(NSURLSessionDataTask * task, id responseObj) {
        //
        ResponseRootObject* rootObj = [ResponseRootObject mj_objectWithKeyValues:responseObj];
        if ([rootObj.ret isEqualToString:@"0"]) {
            NSArray* arr = rootObj.data;
            if (arr.count>0) {
                for (int i = 0; i < arr.count; i++) {
                    Subforum * subforum = [Subforum mj_objectWithKeyValues:arr[i]];
                    Forum * forum = _data[_selectIndex] ;
                    [forum.subforum addObject:subforum];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_rightTableView reloadData];
                    _rightTableView.scrollsToTop = YES;
                });
                [_rightTableViewCurPageDic setObject:[NSNumber numberWithInteger:([number intValue] +1)] forKey:@(_selectIndex)];
            }else{
                [btn setTitle:NOMORE_DES forState:UIControlStateNormal];
            }
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        //
    }];
}
@end
