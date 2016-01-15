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

#warning  1、加载数据分页  2、各tableview点击事件
@implementation DynamicInfoViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
#warning 这个语法跟开源中国中的new一个TableView一样奇怪哦  不加会导致多出一块空的
    self.automaticallyAdjustsScrollViewInsets=NO;
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
    NSLog(@"%d",recognizer.view.tag);
    
    [self setIndicatorPositionWithAnimation:CGPointMake(recognizer.view.center.x, self.labelSelectView.indicatorView.center.y)];
    
    CGFloat offsetX = recognizer.view.tag * self.contentView.frame.size.width;
    CGFloat offsetY = self.contentView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 *  指示条移动
 *
 *  @return <#return value description#>
 */
-(void)setIndicatorPositionWithAnimation:(CGPoint) point{
    //block代码块动画
    [UIView transitionWithView:self.labelSelectView.indicatorView duration:0.5 options:0 animations:^{
        //执行的动画
        //        NSLog(@"动画开始执行前的位置：%@",NSStringFromCGPoint(self.labelSelectView.indicatorView.center));
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
