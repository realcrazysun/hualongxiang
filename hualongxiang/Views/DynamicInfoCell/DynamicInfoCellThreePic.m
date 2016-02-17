//
//  DynamicInfoCellThreePic.m
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DynamicInfoCellThreePic.h"
#import "UIImageView+Util.h"
#import "UIView+Util.h"
@implementation DynamicInfoCellThreePic
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self initSubviews];
        [self setLayout];
    }
    
    return self;
}

-(void)initSubviews{
    _titleLabel= [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    
    _nameLabel                  = [[UILabel alloc] init];
    _nameLabel.numberOfLines    = 1;
    _nameLabel.font             = [UIFont systemFontOfSize:12];
    _nameLabel.alpha            = 0.5;
    [self.contentView addSubview:_nameLabel];
    
    _readcountLabel                 = [UILabel new];
    _readcountLabel.numberOfLines   = 1;
    _readcountLabel.font            = [UIFont systemFontOfSize:12];
    _readcountLabel.alpha           = 0.5;
    [self.contentView addSubview:_readcountLabel];
    
    
    _timeLabel                 = [UILabel new];
    _timeLabel.numberOfLines   = 1;
    _timeLabel.font            = [UIFont systemFontOfSize:12];
    _timeLabel.alpha           = 0.5;
    [self.contentView addSubview:_timeLabel];
    
    _viewForImg = [UIImageView new] ;
//    _viewForImg.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_viewForImg];
}

-(void)setLayout{
    
    for (UIView *view in self.contentView.subviews) {view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel, _titleLabel,_readcountLabel,_viewForImg,_timeLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[_titleLabel]-8-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[_viewForImg]-8-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[_nameLabel]-10-[_readcountLabel]->=10-[_timeLabel]-8-|"
                                                                             options:NSLayoutFormatAlignAllTop
                                                                             metrics:nil
                                                                               views:views]];
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel]-10-[_viewForImg]-10-[_nameLabel]-8-|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    
    
   
}
/**
 *  加载两到三张图片
 *
 *  @param arr 图片url数组
 */
-(void)setImgArr:(NSArray*)arr{
#warning 要先加layoutIfNeeded才能使约束有效  但是这里iPhone6s 和 5s显示的宽度并不一致 在6s上依然无法正确取出对应的frame宽度
    [self layoutIfNeeded];
    for (int i = 0; i < arr.count; i++) {
        CGFloat width  = (_viewForImg.frame.size.width - 20 )/3;
        CGFloat height = width*3/4;
        CGFloat x = (width  + 10 ) * i;
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
        if (arr[i]) {
            NSURL* url = [NSURL URLWithString:arr[i]];
            [imageView loadPortrait:url];
//            [imageView setBorderWidth:1 andColor:[UIColor grayColor]];
            [_viewForImg addSubview:imageView];
        }
    }
}

@end
