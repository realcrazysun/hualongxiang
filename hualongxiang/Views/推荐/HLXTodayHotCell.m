//
//  HLXTodayHotCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/17.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HLXTodayHotCell.h"
#import "UIImageView+Util.h"
#import "UIView+Util.h"
#import "CommonDefines.h"
#import "RecommendObject.h"
@interface HLXTodayHotCell()
{
    UIScrollView *_scrollView;
}
@end

@implementation HLXTodayHotCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建scrollview
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self.contentView addSubview:_scrollView];
    }
    return self;
}


-(void)setDataArr:(NSArray *)arr{
    _arr = arr;
    _scrollView.contentSize = CGSizeMake((TodayHotCellSingleViewWidth+10)*arr.count, _scrollView.frame.size.height);
    for (int i = 0; i<arr.count; i++) {
        CGRect frame = CGRectMake(10+i*(TodayHotCellSingleViewWidth+10), 15, TodayHotCellSingleViewWidth, TodayHotCellSingleViewWidth);
        HLXTodayHotView* view = [[HLXTodayHotView alloc] initWithFrame:frame];
        view.tag = i;
        
        TodayHot* model = arr[i];
        [view loadPortraitWithNSString:model.cover];
        [view.icon loadPortraitWithNSString:model.avatar];
        [view.label setText:model.nickname];
        [_scrollView addSubview:view];
        UIGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView:)];
        [view addGestureRecognizer:recognizer];
    }
}

- (void)clickView:(UIGestureRecognizer*)recognizer{
    NSLog(@"%d",recognizer.view.tag);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation HLXTodayHotView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat viewHeight = 20;
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-viewHeight, frame.size.width, viewHeight)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.6;
        [self addSubview:view];
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewHeight, viewHeight)];
        [view addSubview:_icon];
        [_icon setCornerRadius:10];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(viewHeight+10, 0, view.frame.size.width-(viewHeight+5), viewHeight)];
        [view addSubview:_label];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:12];
        _label.numberOfLines = 1;

    }
    return self;
}

@end