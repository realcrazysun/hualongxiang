//
//  HLXFriendCircleViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/16.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HLXFriendCircleViewController.h"
#import "UIColor+Wonderful.h"
#import "CommonDefines.h"
#import "HLXTopicMainViewController.h"
#import "HLXRecommendTableViewController.h"
#import "DarenViewController.h"
@interface HLXFriendCircleViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView* indicatorView;
@property(nonatomic,strong)UIView* btnView;
@property(nonatomic,copy)NSMutableArray* btnArr;
@property(nonatomic,strong)UIScrollView* contentView;
@end

@implementation HLXFriendCircleViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        _btnArr = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setNav];
    [self initContentView];
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
}
/**
 *  设置导航栏  三个按钮
 */
-(void)setNav{
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_pai_photo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(onClickRightMenuButton)];
    

    
    CGFloat width = 200;
    CGRect btnViewRect  = CGRectMake(ScreenWidth/2 - width/2, 0, 200, self.navigationController.navigationBar.frame.size.height-2);
    _btnView = [[UIView alloc] initWithFrame:btnViewRect];
    _btnView.backgroundColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar addSubview:_btnView];
    
    NSArray* btnTextString = @[@"话题",@"推荐",@"达人" ];
    for (int i = 0; i < 3; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        CGFloat btnWidth = _btnView.frame.size.width/3;
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, _btnView.frame.size.height);
        [btn setTitle:btnTextString[i] forState:UIControlStateNormal];
        [_btnView addSubview:btn];
        [_btnArr addObject:btn];
        if (i == 0) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(btnViewRect.origin.x, self.navigationController.navigationBar.frame.size.height-2, btnViewRect.size.width, 2)];
    lineView.backgroundColor = [UIColor clearColor];
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, lineView.frame.size.width/3, lineView.frame.size.height)];
    _indicatorView.backgroundColor = [UIColor whiteColor];
    [lineView addSubview:_indicatorView];
    [self.navigationController.navigationBar addSubview:lineView];
}

/**
 点击导航栏右边按钮
 
 - returns: void
 */
-(void)onClickRightMenuButton{
    
}

/**
 *  初始化内容滚动栏
 */
-(void)initContentView{
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, self.view.frame.size.height - 64)];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.contentSize = CGSizeMake(ScreenWidth*3, self.view.frame.size.height - 64);
    _contentView.delegate = self;
    _contentView.pagingEnabled = YES;
    _contentView.alwaysBounceVertical = NO;
    _contentView.alwaysBounceHorizontal = YES;
    _contentView.bounces = NO;
    [self.view addSubview:_contentView];
    [self initControllers];
}

-(void)btnClicked:(UIButton*)btn{
    [self btnChangeToIndex:btn.tag];
    CGFloat offsetX = btn.tag * self.contentView.frame.size.width;
    CGFloat offsetY = self.contentView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.contentView setContentOffset:offset animated:YES];

}

-(void)btnChangeToIndex:(NSUInteger)index{
    UIButton* btn =_btnArr[index];
    [UIView transitionWithView:_indicatorView duration:0.5 options:0 animations:^{
        _indicatorView.center = CGPointMake(btn.center.x,  _indicatorView.center.y)  ;
    }completion:^(BOOL finished) {
        
    }];
    for (UIView* view in _btnView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton*)view setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)initControllers{
    HLXTopicMainViewController* controller1 = [[HLXTopicMainViewController alloc] init];
//    controller1.view.backgroundColor = [UIColor redColor];
    
    HLXRecommendTableViewController* controller2 = [[HLXRecommendTableViewController alloc] init];
//    controller2.view.backgroundColor = [UIColor blueColor];
    
    DarenViewController* controller3 = [[DarenViewController alloc] init];
//    controller3.view.backgroundColor = [UIColor yellowColor];
    
    [self addChildViewController:controller1];
    [self addChildViewController:controller2];
    [self addChildViewController:controller3];
}

#pragma mark --contentView 代理
/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.contentView.frame.size.width;
    [self btnChangeToIndex:index];
    
    UIViewController *vc = self.childViewControllers[index];
    if (vc.view.superview) return;
    vc.view.frame = scrollView.bounds;
    [self.contentView addSubview:vc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
