//
//  CellWithNoPicTableViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/2/18.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "CellWithNoPicTableViewCell.h"
#import "UIView+SDAutoLayout.h"
@interface CellWithNoPicTableViewCell()
{
    UILabel *_contentLabel;
    UILabel *_nameLabel;
    UILabel *_readLabel;
    UILabel *_timeLabel;
}
@end
@implementation CellWithNoPicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

-(void)setup{

    //内容
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.numberOfLines = 2;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.textColor = [UIColor blackColor];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.alpha = 0.5;
    _nameLabel.numberOfLines = 1;
//    _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    _readLabel = [UILabel new];
    _readLabel.font = [UIFont systemFontOfSize:13];
    _readLabel.textColor = [UIColor blackColor];
    _readLabel.alpha = 0.5;
    _readLabel.numberOfLines = 1;
//    _readLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.alpha = 0.5;
    _timeLabel.numberOfLines = 1;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    
//    _timeLabel.lineBreakMode = NSLineBreakByCharWrapping;

    NSArray *views = @[_contentLabel, _nameLabel, _readLabel,  _timeLabel];
    
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
#pragma mark autoHeightRatio 多行 高度自适应
    _contentLabel.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .rightSpaceToView(contentView,margin).autoHeightRatio(0);
   
    
    _nameLabel.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(_contentLabel,margin)
    .heightIs(18).autoHeightRatio(0);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];

    
    _readLabel.sd_layout
    .leftSpaceToView(_nameLabel,margin+5)
    .topEqualToView(_nameLabel)
    .heightIs(18).autoHeightRatio(0);
    [_readLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _timeLabel.sd_layout
    .rightSpaceToView(contentView,margin)
    .topEqualToView(_nameLabel)
    .heightIs(18).autoHeightRatio(0);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    
    
    [self setupAutoHeightWithBottomView:_readLabel bottomMargin:margin + 5];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setData:(NSString *)content name:(NSString*)name readCount:(NSString*)readCount time:(NSString*)time
{
    _contentLabel.text = content;
//    [_contentLabel sizeToFit];
    _nameLabel.text = name;
    _readLabel.text = [NSString stringWithFormat:@"%@",readCount ];
    _timeLabel.text = time;
    
#warning sizeToFit 确保自适应label内容
    [_nameLabel sizeToFit];
    [_readLabel sizeToFit];
    [_timeLabel sizeToFit];
      
  
}


@end
