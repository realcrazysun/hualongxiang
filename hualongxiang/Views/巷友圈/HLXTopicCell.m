//
//  HLXTopicCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/16.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HLXTopicCell.h"
#import "CommonDefines.h"
#import "UIImageView+Util.h"
@interface HLXTopicCell ()
{
    UIImageView *_imageView;/**< 图 */
    UILabel *_titleLabel;/**< 大标题 */
    UILabel *_subtitleLabel;/**< 小标题 */
}

@end

@implementation HLXTopicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 , 5, 60 , 60)];
    [self.contentView addSubview:_imageView];
    //
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 5, ScreenWidth-100, 30)];
    [self.contentView addSubview:_titleLabel];
    //
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 35, ScreenWidth-100, 40)];
    _subtitleLabel.font = [UIFont systemFontOfSize:13];
    _subtitleLabel.textColor = [UIColor lightGrayColor];
    _subtitleLabel.numberOfLines = 2;
    [self.contentView addSubview:_subtitleLabel];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HLXTopic*)topic{
    _model = topic;
    [_imageView loadPortraitWithNSString:topic.icon];
    _titleLabel.text = topic.name;
    _subtitleLabel.text = topic.num_str;
}

@end
