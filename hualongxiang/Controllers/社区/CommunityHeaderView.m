//
//  CommunityHeaderView.m
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "CommunityHeaderView.h"
#import "CommonDefines.h"
@implementation CommunityHeaderView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

-(void)initSubViews{
    NSLog(@"initWithCoder--");
    self.scrollView.pagingEnabled = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.bounces = NO;
    self.scrollView.backgroundColor = [UIColor grayColor];
    NSLog(@"_scrollView.contentSize.height--%f", _scrollView.contentSize.height);
    self.scrollView.backgroundColor = [UIColor grayColor];
    

    [self.leftBtn setHighlighted:YES];
    [self.leftBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

//加载热门板块
-(void)load:(NSArray*)arr{
    int pageCount = (arr.count-1)/8 + 1;
    
    NSLog(@"load--");
    for (int i = 0; i < pageCount; i++) {
        CGRect frame = CGRectMake(_scrollView.frame.size.width*i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        NSUInteger max = i==pageCount-1?i*8:arr.count-1;
        NSArray* pageArr = [arr subarrayWithRange:NSMakeRange(i*8, max)];
        IconPage* page = [[IconPage alloc] initWithFrame:frame andArr:pageArr];
        
        [_scrollView addSubview:page];
    }
}

-(void)btnClicked:(UIButton*)btn{
    if (btn == _leftBtn) {
        NSLog(@"left");
        [_rightBtn setHighlighted:NO];
    }else{
        [_leftBtn setHighlighted:NO];
    }
    [btn setHighlighted:YES];
    
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
        CGFloat viewWidth = frame.size.width;
        for (int i = 0; i < arr.count; i++) {
            int row = i/4;
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(20+(viewWidth+20)*i, 5+row*(viewWidth + 15+5), viewWidth, viewWidth + 15)];
            
            [self addSubview:view];
        }
    }
    return self;
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
        _label.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), frame.size.width, 20);
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}

@end