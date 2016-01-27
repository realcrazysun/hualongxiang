//
//  CommunityHeaderView.m
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "CommunityHeaderView.h"
#import "CommonDefines.h"
#import "UIImageView+Util.h"
#import "CommuityModel.h"
@interface CommunityHeaderView()
@property(nonatomic,assign)int currentIndex;

@end

@implementation CommunityHeaderView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currentIndex = 0;
        [self initSubViews];
       
    }
    return self;
}

-(void)initSubViews{
    self.scrollView.pagingEnabled = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.bounces = NO;
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    
    [self.leftBtn setHighlighted:YES];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
   
}

-(void)initData:(NSArray *)attention recommend:(NSArray *)recommend lastRefreshTime:(NSString*)lastRefreshTime{
    _attention = attention;
    _recommend = recommend;
    _time.text =  [NSString stringWithFormat:@"最后刷新:   %@",lastRefreshTime];
    if (_currentIndex == 0) {
        [self load:CommunityTypeHot];
    }else{
        [self load:CommunityTypeFav];
    }
}
//加载热门板块
-(void)load:(CommunityType)type{
#warning   --先layout 再用frame
    [self layoutIfNeeded];
    for (UIView* view in  _scrollView.subviews) {
        [view removeFromSuperview];
    }
    NSArray* arr;
    switch (type) {
        case CommunityTypeHot:
            arr = _recommend;
            break;
            
        default:
            arr = _attention;
            break;
    }
    if (arr.count == 0) {
        return;
    }
    int pageCount = (arr.count-1)/8 + 1;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*pageCount, _scrollView.frame.size.height);
    for (int i = 0; i < pageCount; i++) {
        CGRect frame = CGRectMake(_scrollView.frame.size.width*i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        NSUInteger length = (i==pageCount-1)?(arr.count - 8*i):8;
        NSArray* pageArr = [arr subarrayWithRange:NSMakeRange(i*8, length)];
        IconPage* page = [[IconPage alloc] initWithFrame:frame andArr:pageArr];
        page.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:page];
    }
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_scrollView.frame.size.width/2-50,  CGRectGetMaxY(_scrollView.frame)-30, 100, 30)];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self bringSubviewToFront:self.pageControl];
#pragma mark--不应该放在scrollView上面 会随着scrollView滚动的
    [self addSubview:self.pageControl];
}

- (IBAction)btnClicked:(UIButton *)btn {
    if (btn == _leftBtn) {
        _currentIndex  = 0;
        [self load:CommunityTypeHot];
        _rightBtn.alpha = 0.5;
    }else{
        _currentIndex  = 1;
        [self load:CommunityTypeFav];
        _leftBtn.alpha = 0.5;
    }
    btn.alpha = 1;
    
    [UIView transitionWithView:_indicatorView duration:0.5 options:0 animations:^{
        _indicatorView.center = CGPointMake(btn.center.x, _indicatorView.center.y);
    } completion:^(BOOL finished) {
    }];
}


@end

@implementation IconPage

-(instancetype)initWithFrame:(CGRect)frame andArr:(NSArray *)arr{
    self = [super initWithFrame:frame];
    if (self) {
        _arr = arr;
        CGFloat viewWidth = (frame.size.width - 5*20)/4;
        for (int i = 0; i < arr.count; i++) {
            int row = i/4;
            IconView* view = [[IconView alloc] initWithFrame:CGRectMake(20+(viewWidth+20)*(i%4), 5+row*(viewWidth + 15+15), viewWidth, viewWidth + 15)];
            CommuityBlockModel* model = arr[i];
            [view setData:model.logo title:model.name];
            UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
            view.tag = i;
            [view addGestureRecognizer:recognizer];
            [self addSubview:view];
        }
    }
    return self;
}

-(void)clickView:(UIGestureRecognizer*)recognizer{
    NSLog(@"%d",recognizer.view.tag);
    
}

@end

@implementation IconView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init] ;
        _imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
        _imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:_imageView];
        _label = [UILabel new];
        _label.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame)+5, frame.size.width, 20);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"123";
        _label.font = [UIFont systemFontOfSize:13];
        _label.alpha = 0.5;
        [self addSubview:_label];
    }
    return self;
}

-(void)setData:(NSString*)imgUr title:(NSString*)title{
    if (imgUr) {
        NSURL* url = [NSURL URLWithString:imgUr];
        [_imageView loadPortrait:url];
    }
    _label.text = title;
}
@end