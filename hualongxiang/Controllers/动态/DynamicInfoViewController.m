//
//  DynamicInfoViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DynamicInfoViewController.h"
#import "NoticInfoTableViewController.h"
#import "HotInfoTableViewController.h"
#import "ActivityInfoController.h"
#import "SearchViewController.h"

@implementation DynamicInfoViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets=NO;
    //导航栏添加图片
    UIImageView* navImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_top"]];

    CGRect frame = CGRectMake(navImageView.frame.origin.x,navImageView.frame.origin.y,navImageView.frame.size.width*3/4,navImageView.frame.size.height*3/4);
    navImageView.frame = frame;
    navImageView.center = CGPointMake(self.view.frame.size.width/2, 20);
    self.navigationItem.titleView = navImageView;
//    [self.navigationController.navigationBar addSubview:navImageView];
#pragma mark -- imageWithRenderingMode 去掉颜色混合  实用tip
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                                                                                style:UIBarButtonItemStylePlain
                                                                                                                                                 target:self action:@selector(onClickRightMenuButton)];
                                                             

                                                         
    [self addClickTitleEvent];
    [self addController];
    
    //设置底部滚动视图
    CGFloat contentX = 3 * [UIScreen mainScreen].bounds.size.width;
    self.contentView.contentSize = CGSizeMake(contentX, 0);
    self.contentView.pagingEnabled = YES;
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.bounces = NO ;
    self.contentView.delegate = self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//     self.navigationItem.titleView.hidden = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
//    self.navigationItem.titleView.hidden = YES;
    [super viewDidDisappear:animated];
    
}
/**
 *  导航栏rightBarButtonItem点击事件
 */
-(void)onClickRightMenuButton{
    SearchViewController *vc = [SearchViewController new];
//    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 *  增加标签点击事件
 */
-(void)addClickTitleEvent{
    UITapGestureRecognizer* recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    UITapGestureRecognizer* recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    UITapGestureRecognizer* recognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.labelSelectView.noticeView addGestureRecognizer:recognizer1];
    [self.labelSelectView.hotView addGestureRecognizer:recognizer2];
    [self.labelSelectView.activityView addGestureRecognizer:recognizer3];
    
}

-(void)click:(UITapGestureRecognizer*)recognizer{
    [self setIndicatorPositionWithAnimation:CGPointMake(recognizer.view.center.x, self.labelSelectView.indicatorView.center.y)];
    
    CGFloat offsetX = recognizer.view.tag * self.contentView.frame.size.width;
    CGFloat offsetY = self.contentView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 *  指示条移动
 *
 *  @return
 */
-(void)setIndicatorPositionWithAnimation:(CGPoint) point{
    //block代码块动画
    [UIView transitionWithView:self.labelSelectView.indicatorView duration:0.5 options:0 animations:^{
        //执行的动画
        self.labelSelectView.indicatorView.center = point;
        
    } completion:^(BOOL finished) {
        //动画执行完毕后的首位操作
        
    }];
}
/**
 *  添加子控制器
 */
- (void)addController
{
    NoticInfoTableViewController* controller1 = [[NoticInfoTableViewController alloc] init];
    //    controller1.view.backgroundColor = [UIColor redColor];
    
    HotInfoTableViewController* controller2 = [[HotInfoTableViewController alloc] init];
    //    controller2.view.backgroundColor = [UIColor blueColor];
    
    ActivityInfoController* controller3 = [[ActivityInfoController alloc] init];
    //    controller3.view.backgroundColor = [UIColor yellowColor];
    
    [self addChildViewController:controller1];
    [self addChildViewController:controller2];
    [self addChildViewController:controller3];
}

#pragma mark --contentView 代理
/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat x = ABS(scrollView.contentOffset.x / scrollView.contentSize.width)*scrollView.bounds.size.width + self.labelSelectView.indicatorView.frame.size.width/2;
    CGFloat y = self.labelSelectView.indicatorView.center.y;
    [self setIndicatorPositionWithAnimation:CGPointMake(x, y)];
}


/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.contentView.frame.size.width;
    
    UIViewController *newsVc = self.childViewControllers[index];
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.contentView addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
