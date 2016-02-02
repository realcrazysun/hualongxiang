//
//  DarenViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/28.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DarenViewController.h"
#import "UIColor+Wonderful.h"
#import "CommonDefines.h"
#import "DarenTableViewController.h"
#define ContainerHeight  40 //顶部标题栏高度
@interface DarenViewController()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView* contentView;
@property(nonatomic,strong)UIButton* leftBtn;
@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic,strong)UIView* indicatorView;
@end
@implementation DarenViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTitleView];
    [self initContentView];
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
}

-(void)initContentView{
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ContainerHeight, ScreenWidth, self.view.frame.size.height - 30)];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.contentSize = CGSizeMake(ScreenWidth*2, self.view.frame.size.height - 30);
    _contentView.delegate = self;
    _contentView.pagingEnabled = YES;
    _contentView.alwaysBounceVertical = NO;
    _contentView.alwaysBounceHorizontal = NO;
    _contentView.bounces = NO;
    _contentView.scrollEnabled = NO;
    [self.view addSubview:_contentView];
    [self initControllers];
}

-(void)initControllers{

        DarenTableViewController* controller1 = [[DarenTableViewController alloc] initWithType:TwentyFourHour];
        //    controller1.view.backgroundColor = [UIColor redColor];
        
        DarenTableViewController* controller2 = [[DarenTableViewController alloc] initWithType:Total];        //    controller2.view.backgroundColor = [UIColor blueColor];
        [self addChildViewController:controller1];
        [self addChildViewController:controller2];

}
-(void)initTitleView{

    UIView* btnContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ContainerHeight)];
    btnContainer.backgroundColor = [UIColor whiteSmoke];
//    btnContainer.alpha = 0.5;
    [self.view addSubview:btnContainer];
    
    CGFloat btnW = self.view.frame.size.width/2 - 20 -20;
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(20, 0, btnW, ContainerHeight-3);
    [_leftBtn setTitle:@"24h活跃度" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.tag = 0;
    [btnContainer addSubview:_leftBtn];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(self.view.frame.size.width/2+ 20, 0, btnW, ContainerHeight-3);
    [_rightBtn setTitle:@"总活跃度" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.tag = 1;
    [btnContainer addSubview:_rightBtn];
    
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(20, ContainerHeight-3, btnW, 3)];
    _indicatorView.backgroundColor = [UIColor meituanColor];
    [btnContainer addSubview:_indicatorView];
}

-(void)clickBtn:(UIButton*)clickedBtn{
    //indecatorview
    [UIView transitionWithView:_indicatorView duration:0.5 options:0 animations:^{
        _indicatorView.center = CGPointMake(clickedBtn.center.x,  _indicatorView.center.y)  ;
    }completion:^(BOOL finished) {
        
    }];
    
    for (UIButton* btn in @[_leftBtn,_rightBtn]) {
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    [clickedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    CGFloat offsetY = self.contentView.contentOffset.y;
    CGFloat offsetX = clickedBtn.tag * self.contentView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.contentView setContentOffset:offset animated:YES];
}

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.contentView.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
    if (vc.view.superview) return;
    vc.view.frame = scrollView.bounds;
    [self.contentView addSubview:vc.view];
}

@end
