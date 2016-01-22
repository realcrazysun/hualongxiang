//
//  DiscoverViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/10.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverViewCell.h"
#import "CommonDefines.h"
#import "DiscoverHeaderViewCell.h"
#import "AFHTTPSessionManagerTool.h"
#import "HLXApi.h"
#import "ResponseRootObject.h"
#import "MJExtension.h"
#import "DiscoverSectionModel.h"
#import "DiscoverItemModel.h"
#import "MJRefresh.h"
#import "TOWebViewController.h"
@interface DiscoverViewController ()
@property (nonatomic, strong) NSMutableArray *sections;
@end

@implementation DiscoverViewController

static NSString * const reuseIdentifier         = @"itemCell";
#pragma mark--注意空白cell重用 可以注册同一个class
static NSString * const blankReuseIdentifier    = @"blankitemCell";
static NSString * const reuseHeaderIdentifier   = @"HeaderViewCell";

- (id)init
{
    // 创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置cell尺寸
    CGFloat width = ScreenWidth / 4;
    CGFloat height = width * 5 / 4;
    layout.itemSize = CGSizeMake(width, height);
    // 设置水平间距
    layout.minimumInteritemSpacing = 0;
    // 设置垂直间距
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    layout.headerReferenceSize = CGSizeMake(0, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithCollectionViewLayout:layout]) {
        _sections = [NSMutableArray new];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    
    //导航栏右边按钮
    CGRect frame = self.view.frame;
    UIImageView* rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_nomal"]];
    rightView.frame = CGRectMake(frame.size.width-40, 0, 40, 40);
    UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightNav)];
    [rightView addGestureRecognizer:recognizer];
    [self.navigationController.navigationBar addSubview:rightView];
    
    [self.collectionView registerClass:[DiscoverViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[DiscoverViewCell class] forCellWithReuseIdentifier:blankReuseIdentifier];
    [self.collectionView registerClass:[DiscoverHeaderViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
    
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.collectionView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refresh];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
}
//点击导航栏右边按钮
-(void)clickRightNav{
    
}
/**
 *  下拉刷新
 */
-(void)refresh{
    [AFHTTPSessionManagerTool sendHttpGET:HLXAPI_DISCOVER prefix:HLXAPI_PREFIX parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseJsonObject) {
        //刷新数据
        ResponseRootObject* model = [ResponseRootObject mj_objectWithKeyValues:responseJsonObject];
        if ([model.ret isEqualToString:@"0"]) {
//            NSLog(@"数据返回成功");
            [_sections removeAllObjects];
            NSArray* arr = model.data;
            for (int i = 0; i < arr.count; i++) {
                DiscoverSectionModel * sectionModel = [DiscoverSectionModel mj_objectWithKeyValues:arr[i]];
                [_sections addObject:sectionModel];
            }
            [self.collectionView reloadData];
        }
        
        if([self.collectionView.mj_header isRefreshing]){
            [self.collectionView.mj_header endRefreshing];
        }
//        NSLog(@"%@",responseJsonObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"%@",@"failed");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DiscoverSectionModel* model = _sections[section];
    int count = (int)model.val.count;
    if (count % 4 == 0) {
        return model.val.count;
    }
    return ((int)count/4 + 1)*4;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_sections count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DiscoverSectionModel* sectionModel = _sections[indexPath.section];
    if (indexPath.row < sectionModel.val.count) {
        DiscoverViewCell *cell = (DiscoverViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [cell sizeToFit];
        DiscoverItemModel* itemModel = sectionModel.val[indexPath.row];
        [cell setImgUrl:itemModel.cover];
        cell.text.text = [NSString stringWithFormat:@"%@",itemModel.name];
        
        return cell;
    }
    
    //空白cell重用
    DiscoverViewCell *cell = (DiscoverViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:blankReuseIdentifier forIndexPath:indexPath];
    [cell sizeToFit];
    [cell setImgUrl:nil];
    cell.text.text = @"";
    return cell;
}

//section定义
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        DiscoverHeaderViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
        [cell sizeToFit];
        DiscoverSectionModel* model = _sections[indexPath.section];
        [cell.textLabel setText:model.title] ;
        return cell;
    }
    return nil;
}


#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverViewCell* cell = (DiscoverViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:reuseIdentifier]) {
        NSLog(@"点击了单个collectionViewCell 而不是 空白 cell");
        DiscoverSectionModel* sectionModel = _sections[indexPath.section];
        DiscoverItemModel*  itemModel      = sectionModel.val[indexPath.row];
        TOWebViewController* webController = [[TOWebViewController alloc] initWithURLString:itemModel.url];
        webController.showUrlWhileLoading  = NO;
//        webController.showActionButton     = NO;
//        webController.showDoneButton       = YES;
//        webController.doneButtonTitle = @"...";
        [self.navigationController pushViewController:webController animated:YES];
    }
}



@end
