//
//  RightMenuCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "RightMenuCell.h"
#import "UIView+Util.h"
#import "UIImageView+Util.h"
@interface RightMenuCell()
@property(nonatomic,strong)UIImageView* logoView;
@property(nonatomic,strong)UILabel* titleLabel;
@end
@implementation RightMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _logoView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        [_logoView setCornerRadius:5];
        [self.contentView addSubview:_logoView];
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_logoView.frame)+5, 5, 150, 50);
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}
-(void)setData:(Subforum *)data{
    _data = data;
    [_logoView loadPortraitWithNSString:data.logo];
    _titleLabel.text = data.name;
}
@end
