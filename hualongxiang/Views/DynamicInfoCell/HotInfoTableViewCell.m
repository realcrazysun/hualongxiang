//
//  HotInfoTableViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/13.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HotInfoTableViewCell.h"
#import "UIColor+Wonderful.h"
#import "UIView+Util.h"
#import "UIImageView+Util.h"
#import "CommonDefines.h"
@interface HotInfoTableViewCell()
{
    HotInfoHeadModel* _header;
    NSArray* _newsArr;
}
@property(strong,nonatomic)UIView* backgroundImgView;
@property(nonatomic ,strong)UILabel *time;
@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *imgText;
@property(nonatomic ,strong)NSMutableArray *newsViewArr;
@end
@implementation HotInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor silverColor];
        _newsViewArr = [NSMutableArray new];
        [self setup];
    }
    return self;
}

-(void)setup{
    
    //用frame模型方便等分  计算  最好是填充数据时 根据数据动态计算frame  VFL如何动态添加view是一个问题
    CGFloat width   = ScreenWidth;
    CGFloat height  = HotInfoCellHeight;
    
    _time                      = [[UILabel alloc] initWithFrame:CGRectMake(width/2-35, 5, 70, 20)];
    _time.numberOfLines        = 1;
    _time.font                 = [UIFont systemFontOfSize:13];
    [_time setCornerRadius:3];
    _time.backgroundColor = [UIColor grayColor];
    [_time setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_time];
    
    CGFloat y = CGRectGetMaxY(_time.frame)+5;
    _backgroundImgView = [[UIView alloc] initWithFrame:CGRectMake(5, y, width-5*2, HotInfoCellHeight-y)];
    _backgroundImgView.backgroundColor = [UIColor whiteColor];
    [_backgroundImgView setCornerRadius:2];
    [self.contentView addSubview:_backgroundImgView];
    
    CGRect imageViewRect = CGRectMake(5, 5, _backgroundImgView.frame.size.width -10, 130);
    _imgView = [[UIImageView alloc] initWithFrame:imageViewRect];
    _imgView.backgroundColor = [UIColor blueColor];
    [_backgroundImgView addSubview:_imgView];

    CGRect imageTextRect = CGRectMake(0, _imgView.frame.size.height-40, _imgView.frame.size.width , 40);
    _imgText = [[UILabel alloc] initWithFrame:imageTextRect];
    _imgText.alpha = 0.7;
    _imgText.numberOfLines = 2;
    _imgText.font = [UIFont systemFontOfSize:14];
    _imgText.lineBreakMode = NSLineBreakByWordWrapping;
    _imgText.backgroundColor = [UIColor blackColor];
    _imgText.textColor = [UIColor whiteColor];
    [_imgView addSubview:_imgText];
    _imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImg)];
    [_imgView addGestureRecognizer:tapImg];
    
#warning  cell不应该动态添加view 否则cell重用会有问题
    CGFloat _backgroundImgViewWidth = _backgroundImgView.frame.size.width;
    CGFloat newsViewHeight = (_backgroundImgView.frame.size.height - CGRectGetMaxY(_imgView.frame))/4;
    
    for (int i = 0; i < 4; i++) {
        CGRect viewRect = CGRectMake(0, CGRectGetMaxY(_imgView.frame)+newsViewHeight*i, _backgroundImgViewWidth, newsViewHeight);
        NewsView* view = [[NewsView alloc] initWithFrame:viewRect];
        [_newsViewArr addObject:view];
        [_backgroundImgView addSubview:view];
    }
}

-(void)setData:(NSString*)timeString
        header:(HotInfoHeadModel*)header
          news:(NSArray*)arr{
    _header = header;
    _newsArr = arr;
    
    _time.text = timeString;
    NSURL* url = [NSURL URLWithString:header.cover];
    [_imgView loadPortrait:url];
    _imgText.text = header.replaceTitle;
    
    for (int i = 0; i < 4; i++) {
        HotInfoBodyModel* model = arr[i];
        NewsView* view = _newsViewArr[i];
        view.text.text = model.replaceTitle;
        NSURL* url = [NSURL URLWithString:model.cover];
        view.tag = i;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [view addGestureRecognizer:recognizer];
        [view.imgView loadPortrait:url];
    }
    
}

-(void)tapImg{
    if (self.tapImgBlock) {
        self.tapImgBlock();
    }
}
-(void)tapView:(UIGestureRecognizer*)recognizer{
    if (self.tapViewBlock) {
        self.tapViewBlock(recognizer.view.tag);
    }
}

@end

@implementation NewsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        CGFloat width = frame.size.height - 10;
        CGFloat imgX = frame.size.width - 5 - width;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, 5, width, width)];
        
        [self addSubview:_imgView];
        
        _text = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,CGRectGetMinX(_imgView.frame) - 10, frame.size.height -10)];
        _text.alpha = 0.8;
        _text.font = [UIFont systemFontOfSize:14];
        _text.numberOfLines = 2;
        _text.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_text];
        
    }
    return self;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    [self setBackgroundColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0]];
//}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesEnded:touches withEvent:event];
//    [self setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
//}
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesCancelled:touches withEvent:event];
//    [self setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
//}

@end
