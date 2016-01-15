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
    CGFloat width   =     ScreenWidth;
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
    _time.text = timeString;
    NSURL* url = [NSURL URLWithString:header.cover];
    [_imgView loadPortrait:url];
    _imgText.text = header.replaceTitle;
    
    for (int i = 0; i < 4; i++) {
        HotInfoBodyModel* model = arr[i];
        NewsView* view = _newsViewArr[i];
        view.text.text = model.replaceTitle;
        NSURL* url = [NSURL URLWithString:model.cover];
        [view.imgView loadPortrait:url];
    }
    
}

//
//-(void)initSubviews{
//    
//    _time                      = [UILabel new];
//    _time.numberOfLines        = 1;
//    _time.font                 = [UIFont systemFontOfSize:13];
//    [_time setCornerRadius:2];
//    _time.backgroundColor = [UIColor grayColor];
//    _time.textColor       = [UIColor whiteColor];
//    [self.contentView addSubview:_time];
//    [_time setTextAlignment:NSTextAlignmentCenter];
//    
//    _backgroundImgView = [[UIView alloc] init];
//    _backgroundImgView.backgroundColor = [UIColor whiteColor];
//    [_backgroundImgView setCornerRadius:3];
//    
//    [self.contentView addSubview:_backgroundImgView];
//    
//    
//    
//}
//#warning 这样写太麻烦了  而且扩展性太差  stackView能解决问题？   暂时用写死的frame计算一下吧
//-(void)setLayout{
//    
//    for (UIView *view in self.contentView.subviews) {view.translatesAutoresizingMaskIntoConstraints = NO;}
//    
//    NSDictionary *views = NSDictionaryOfVariableBindings(_time, _backgroundImgView);
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|->=100-[_time(<=80)]->=100-|"
//                                                                             options:0
//                                                                             metrics:nil views:views]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_backgroundImgView]-10-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_time]-5-[_backgroundImgView]-0-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
//    
//    [self.contentView addConstraint:
//     [NSLayoutConstraint constraintWithItem:_time attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
//    
//}
//
/**
 *  填充数据
 *
 *  @param imageUrl  顶部图片
 *  @param imgString 图片描述
 *  @param arr       底部图文新闻
 */
//-(void)setImgArr:(NSString*)imageUrl  imgString:(NSString*)imgString news:(NSArray*)arr{
//    UIImageView* imageView = [UIImageView new];
//    imageView.backgroundColor = [UIColor redColor];
//    imageView.translatesAutoresizingMaskIntoConstraints = NO;//注意嵌套时要单独设置
//    [_backgroundImgView addSubview:imageView];
//}




@end

@implementation NewsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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

@end
