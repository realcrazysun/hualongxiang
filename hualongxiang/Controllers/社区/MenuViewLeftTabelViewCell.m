//
//  MenuViewLeftTabelViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "MenuViewLeftTabelViewCell.h"
#import "UIColor+Wonderful.h"
@interface MenuViewLeftTabelViewCell()
@property(nonatomic,strong) UIView* indicatorView;
@property(nonatomic,strong) UILabel* titleLabel;
@end
@implementation MenuViewLeftTabelViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int indicatorViewW = 10;
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, indicatorViewW, self.contentView.frame.size.height)];
        _indicatorView.backgroundColor = [UIColor deepSkyBlue];
        _indicatorView.hidden = YES;
        [self.contentView addSubview:_indicatorView];
        
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(indicatorViewW, 0, 80 , self.contentView.frame.size.height);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_titleLabel];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;

}
-(void)clicked{
    _indicatorView.hidden = NO;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    self.backgroundColor = LeftSelectBgColor;
}

-(void)reset{
    _indicatorView.hidden = YES;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    self.backgroundColor = LeftBgColor;
}
@end
