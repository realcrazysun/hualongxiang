//
//  UserInfoTableViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/2/16.
//  Copyright © 2016年 crazysun. All rights reserved.
//
#import "SDWeiXinPhotoContainerView.h"
#import "UserInfoTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "UIView+Util.h"
#import "UIColor+Wonderful.h"
#import "UIImageView+Util.h"
#import "NSString+FontAwesome.h"
@interface UserInfoTableViewCell(){
    UIImageView *_iconView;
    UILabel *_nameLable;
    UIImageView *_genderView;
    UILabel *_timeLabel;
    UILabel* _fromLabel;
    UILabel *_contentLabel;
    
    SDWeiXinPhotoContainerView *_picContainerView;
    
    UILabel* _likeLabel;//点赞
    UILabel* _commentLabel;//评论
}

@end
@implementation UserInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    //头像
    _iconView = [UIImageView new];
    
    //昵称
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    _nameLable.numberOfLines = 1;
    [_nameLable setSingleLineAutoResizeWithMaxWidth:250];
    //性别
    _genderView = [UIImageView new];
    //时间
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    //内容
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.numberOfLines = 4;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    //图片展示
    _picContainerView = [SDWeiXinPhotoContainerView new];
    
    //评论按钮
    _commentLabel = [UILabel new];
    _commentLabel.textColor = [UIColor grayColor];
    _commentLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:13];
    
    _likeLabel = [UILabel new];
    _likeLabel.textColor = [UIColor grayColor];
    _likeLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:13];
    //分割view
    UIView* sepView = [UIView new];
    sepView.backgroundColor = [UIColor silverColor];
    
    NSArray *views = @[_iconView, _nameLable, _genderView,  _contentLabel,_commentLabel, _likeLabel,_picContainerView, _timeLabel,sepView];
    
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    [_iconView setCornerRadius:20];
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18)
    .widthIs(100)
    .autoHeightRatio(0);
    //    [_nameLable setSingleLineAutoResizeWithMaxWidth:250];
    
    _genderView.sd_layout
    .leftSpaceToView(_nameLable,3)
    .centerYEqualToView(_nameLable)
    .heightIs(18)
    .widthIs(18);
    
    _timeLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable,5)
    .heightIs(16)
    .autoHeightRatio(0);
    
    
#warning autoHeightRatio 如何使用
    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_timeLabel, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    
    _picContainerView.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_contentLabel,5);
    
    
    
    _commentLabel.sd_layout
    .topSpaceToView(_picContainerView,margin)
    .rightSpaceToView(contentView,margin)
    .heightIs(10)
    .widthIs(40);
    
    _likeLabel.sd_layout
    .rightSpaceToView(_commentLabel,margin)
    .topEqualToView(_commentLabel)
    .heightIs(10)
    .widthIs(40);
    
    sepView.sd_layout
    .topSpaceToView(_commentLabel,margin*2)
    .leftSpaceToView(contentView,0)
    .widthRatioToView(contentView,1)
    .heightIs(10);
    [self setupAutoHeightWithBottomView:sepView bottomMargin:0 ];
    
    
}

- (void)setModel:(UserInfoCellModel *)model
{
    _model = model;
    
    [_iconView loadPortraitWithNSString:model.face];
    _nameLable.text = model.author;
    _contentLabel.text = model.content;
    if ( model.gender == 0) {
        _genderView.image = [UIImage imageNamed:@"userinfo_gender_female"];
        
    }else{
        _genderView.image = [UIImage imageNamed:@"userinfo_gender_male"];
    }
    
    _timeLabel.text = model.dateline;
    NSMutableArray* muteArr = [NSMutableArray new];
    for (NSDictionary* dic in model.imgs) {
        NSMutableDictionary* obj = [[NSMutableDictionary alloc] init];
        [obj setValue:[dic objectForKey:@"width"]  forKey:@"width"];
        [obj setValue:[dic objectForKey:@"height"]  forKey:@"height"];
        [obj setValue:[dic objectForKey:@"attachurl"]  forKey:@"url"];
        [obj setValue:[dic objectForKey:@"attachurl"]  forKey:@"big_url"];
        [muteArr addObject:obj];
    }
    _picContainerView.picPathStringsArray = muteArr;
    
    _likeLabel.text = [NSString stringWithFormat:@"%@ %d",[NSString fontAwesomeIconStringForEnum:FAThumbsUp],model.pingcount];
    _commentLabel.text = [NSString stringWithFormat:@"%@ %d",[NSString fontAwesomeIconStringForEnum:FAComments],model.replies];
    //_address.text = model.address;
    
    //    CGFloat picContainerTopMargin = 0;
    //    if (model.picNamesArray.count) {
    //        picContainerTopMargin = 10;
    //    }
    //    _picContainerView.sd_layout.topSpaceToView(_contentLabel, picContainerTopMargin);
    //    _timeLabel.text = @"1分钟前";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
