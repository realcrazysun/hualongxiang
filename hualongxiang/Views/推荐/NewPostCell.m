//
//  NewPost.m
//  hualongxiang
//
//  Created by polyent on 16/1/18.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "NewPostCell.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "UIView+Util.h"
#import "UIImageView+Util.h"
#import "NSString+FontAwesome.h"
#import "UIColor+Wonderful.h"
#import "MLClickColorLinkLabel.h"
#import "MLLabel+Size.h"

#define CommentLabelFont [UIFont systemFontOfSize:14]

#define CommentLabelLineHeight 1.1f

#define TopMargin 10
#define BottomMargin 6

#define CommentLabelMargin 0

#define UserAvatarSize 40

#define Margin 15

#define  BodyMaxWidth [UIScreen mainScreen].bounds.size.width - UserAvatarSize - 2*Margin

@interface NewPostCell ()
{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UIImageView *_genderView;
    UILabel *_timeLabel;
    UIButton* _copyBtn; //复制 举报
    UILabel *_contentLabel;
    UIButton* _contentExpendBtn;//展开按钮
    SDWeiXinPhotoContainerView *_picContainerView;
    UILabel* _address;
    UIButton* _shareBtn;//分享
    UIButton* _likeBtn;//点赞
    UIButton* _commentBtn;//评论
    UserIconContainerView* _likeListContainer;
    CommentView* _commentListContainer;
}
//@property (nonatomic, strong) NSMutableDictionary *commentDic;
@end
@implementation NewPostCell

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
    
    //复制按钮
    _copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_copyBtn setTitle:@">" forState:UIControlStateNormal];
    [_copyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //内容
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.numberOfLines = 4;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //展开按钮
    _contentExpendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //图片展示
    _picContainerView = [SDWeiXinPhotoContainerView new];
    //地址
    _address = [UILabel new];
    _address.font = [UIFont systemFontOfSize:13];
    _address.textColor = [UIColor deepSkyBlue];
    //分享按钮
    _shareBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [_shareBtn setBackgroundImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    //    [_shareBtn setTitle:[NSString stringWithFormat:@"%@%@",[NSString fontAwesomeIconStringForEnum:FAShare],@" 分享"]forState:UIControlStateNormal];
    //    [_shareBtn setBackgroundColor:[UIColor gainsboroColor]];
    //    [_shareBtn.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:16]];
    //    [_shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //点赞按钮
    _likeBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [_likeBtn setBackgroundImage:[UIImage imageNamed:@"btn_zan_normal"] forState:UIControlStateNormal];
    //    [_likeBtn setTitle:[NSString stringWithFormat:@"%@%@",[NSString fontAwesomeIconStringForEnum:FAThumbsOUp],@"  赞"] forState:UIControlStateNormal];
    //    [_likeBtn setBackgroundColor:[UIColor gainsboroColor]];
    //    [_likeBtn.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:16]];
    //    [_likeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //评论按钮
    _commentBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"btn_pinglun_normal" ] forState:UIControlStateNormal];
    //    [_commentBtn setTitle:[NSString stringWithFormat:@"%@%@",[NSString fontAwesomeIconStringForEnum:FACommentsO],@" 评论"] forState:UIControlStateNormal];
    //    [_commentBtn.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:16]];
    //    [_commentBtn setBackgroundColor:[UIColor gainsboroColor]];
    //    [_commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //点赞头像列表
    _likeListContainer = [UserIconContainerView new];
    //    _likeListContainer.backgroundColor = [UIColor redColor];
    //评论
    _commentListContainer = [CommentView new];
    
    NSArray *views = @[_iconView, _nameLable, _genderView,  _contentLabel,_contentExpendBtn, _picContainerView, _timeLabel,_shareBtn,_likeBtn,_commentBtn,_likeListContainer,_commentListContainer,_copyBtn,_address];
    
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
    
    _copyBtn.sd_layout
    .rightSpaceToView(contentView,margin)
    .topEqualToView(_nameLable)
    .heightIs(18)
    .widthIs(20);
    
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
    
    
    _contentExpendBtn.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel,0)
    .autoHeightRatio(0);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentExpendBtn,5);
    
    _address.sd_layout
    .leftEqualToView(_picContainerView)
    .topSpaceToView(_picContainerView,0);
    [_address setSingleLineAutoResizeWithMaxWidth:150];
    
    _shareBtn.sd_layout
    .leftEqualToView(_address)
    .topSpaceToView(_address,margin)
    .heightIs(25)
    .widthIs(64);
    [_shareBtn setCornerRadius:2];
    
    
    _commentBtn.sd_layout
    .rightSpaceToView(contentView,margin)
    .topEqualToView(_shareBtn)
    .heightIs(25)
    .widthIs(64);
    [_commentBtn setCornerRadius:2];
    
    _likeBtn.sd_layout
    .rightSpaceToView(_commentBtn,20)
    .topEqualToView(_shareBtn)
    .heightIs(25)
    .widthIs(64);
    [_likeBtn setCornerRadius:2];
    
    _likeListContainer.sd_layout
    .leftEqualToView(_shareBtn)
    .topSpaceToView(_shareBtn,5);
    
    _commentListContainer.sd_layout
    .leftEqualToView(_likeListContainer)
    .topSpaceToView(_likeListContainer,0)
    .widthIs(BodyMaxWidth);
    
    [self setupAutoHeightWithBottomView:_commentListContainer bottomMargin:margin ];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(NewPost *)model
{
    _model = model;
    
    [_iconView loadPortraitWithNSString:model.avatar];
    _nameLable.text = model.nickname;
    _contentLabel.text = model.content;
    if ([model.gender isEqualToString:@"0"]) {
        _genderView.image = [UIImage imageNamed:@"userinfo_gender_female"];
        
    }else{
        _genderView.image = [UIImage imageNamed:@"userinfo_gender_male"];
    }
    
    _timeLabel.text = model.created_at;
    _picContainerView.picPathStringsArray = model.attaches;
    _address.text = model.address;
    
    if ([model.address isEqualToString:@""]) {
        _address.sd_layout.heightIs(0);
    }else{
        _address.sd_layout.heightIs(16);
    }
    CGFloat likeHeight = [UserIconContainerView getHeight:model.likes];
    _likeListContainer.sd_layout.heightIs(likeHeight);
    [_likeListContainer setIconArr:model.likes];
    
    NSArray* array = model.replies;
    CGFloat height = [CommentView getHeight:array maxWidth:BodyMaxWidth];
    
    [_commentListContainer updateWithItem:array];
    _commentListContainer.sd_layout.heightIs(height);
    
    
    //_address.text = model.address;
    
    //    CGFloat picContainerTopMargin = 0;
    //    if (model.picNamesArray.count) {
    //        picContainerTopMargin = 10;
    //    }
    //    _picContainerView.sd_layout.topSpaceToView(_contentLabel, picContainerTopMargin);
    //    _timeLabel.text = @"1分钟前";
}

-(void)setCommentViewDelegate:(id<CommentViewDelegate>) delegate{
    _commentListContainer.delegate = delegate;
}

@end

@implementation UserIconContainerView


- (void)setIconArr:(NSArray *)iconArr{
    _iconArr = iconArr;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (_iconArr.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemWH = 20;
    CGFloat margin = 5;
    
    [_iconArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL *  stop) {
        if (idx>=7) {
            *stop = YES;
        }
        UIImageView *imageView = [UIImageView new];
        [imageView loadPortraitWithNSString:[obj objectForKey:@"avatar"]];
        imageView.frame = CGRectMake(idx * (itemWH + margin), margin, itemWH, itemWH);
        [imageView setCornerRadius:itemWH/2];
        [self addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        imageView.tag = idx;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
    }];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake((itemWH + margin)*(_iconArr.count>8?8:_iconArr.count), margin,40, 20)];
    label.text = [NSString stringWithFormat:@"%d 赞" , _iconArr.count];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor lightGrayColor];
    [self addSubview:label];
    
    self.fixedHeight = @(itemWH + margin);
}

+(CGFloat)getHeight:(NSArray *)iconArr{
    if (iconArr.count>0) {
        return 25;
    }
    return 0;
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    //    UIView *imageView = tap.view;
    //    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    //    browser.currentImageIndex = imageView.tag;
    //    browser.sourceImagesContainerView = self;
    //    browser.imageCount = self.picPathStringsArray.count;
    //    browser.delegate = self;
    //    [browser show];
}



@end
@interface CommentView()
@property(nonatomic,strong)UIView* sepLineView;
@end
@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _commentLabels = [NSMutableArray array];
        _sepLineView = [UIView new] ;
        _sepLineView.backgroundColor = [UIColor silverColor];
        _sepLineView.alpha = 0.5;
        _sepLineView.hidden = YES;
        [self addSubview:_sepLineView];
    }
    return self;
}

-(void)updateWithItem:(NSArray*)array
{
    
    if (array.count>0) {
        _sepLineView.frame = CGRectMake(0, 8, self.frame.size.width, 1);
        _sepLineView.hidden = NO;
        
    }else{
        _sepLineView.hidden = YES;
    }
    
    
    CGFloat x, y, width, height;
    CGFloat sumHeight = TopMargin;
    if (array.count > 0) {
        NSUInteger labelCount = _commentLabels.count;
        
        for (int i=0; i<labelCount; i++) {
            MLLinkClickLabel *label = [_commentLabels objectAtIndex:i];
            label.attributedText = nil;
            label.frame = CGRectZero;
            label.hidden = !(i<array.count);
        }
        
        for (int i=0;i<array.count;i++) {
            
            MLLinkClickLabel *label;
            
            if ( labelCount > 0 && i < labelCount) {
                label = [_commentLabels objectAtIndex:i];
            }else{
                label = [self createLinkLabel];
                [_commentLabels addObject:label];
                [self addSubview:label];
            }
            
            ReplyObject *commentItem = [array objectAtIndex:i];
            label.hidden = NO;
            NSMutableArray* commentStrArray = [CommentView genCommentAttrString:array];
            NSAttributedString *str = commentStrArray[i];
            label.attributedText = str ;
            label.uniqueId = [commentItem.replyId longLongValue];
            [label sizeToFit];
            
            //            CGFloat width = self.frame.size.width - 2*CommentLabelMargin;
            CGFloat width = BodyMaxWidth;
            CGSize size = [MLLabel getViewSize:label.attributedText maxWidth:width font:CommentLabelFont lineHeight:CommentLabelLineHeight lines:0];
            x = CommentLabelMargin;
            y = sumHeight;
            height = size.height;
            sumHeight+=height;
            label.frame = CGRectMake(x, y, width, height);
        }
        
    }else{
        
        for (int i=0; i<_commentLabels.count; i++) {
            MLLinkClickLabel *label = [_commentLabels objectAtIndex:i];
            label.attributedText = nil;
            label.frame = CGRectZero;
            label.hidden = YES;
        }
        
    }
    self.fixedHeight =[NSNumber numberWithFloat: [CommentView getHeight:array maxWidth:BodyMaxWidth]] ;
    self.height = [CommentView getHeight:array maxWidth:BodyMaxWidth];
    [self layoutSubviews];
    //    NSLog(@"fixedHeight---%f",[self.fixedHeight floatValue]);
}

+(NSMutableArray*) genCommentAttrString:(NSArray *)comments
{
    NSMutableArray *commentStrArray = [NSMutableArray new];
    for (int i=0; i<comments.count;i++) {
        ReplyObject *comment = [comments objectAtIndex:i];
        //        [_commentDic setObject:comment forKey:comment.replyId];
        
        NSString *resultStr;
        if ([comment.reply_user_id isEqual:@"0" ]) {
            resultStr = [NSString stringWithFormat:@"%@: %@",comment.nickname, comment.content];
        }else{
            resultStr = [NSString stringWithFormat:@"%@回复%@: %@",comment.nickname, comment.reply_nickname, comment.content];
        }
        
        NSMutableAttributedString *commentStr = [[NSMutableAttributedString alloc]initWithString:resultStr];
        if ([comment.reply_user_id isEqual:@"0" ]) {
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%@", comment.user_id] range:NSMakeRange(0, comment.nickname.length)];
        }else{
            NSUInteger localPos = 0;
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%@", comment.user_id] range:NSMakeRange(localPos, comment.nickname.length)];
            localPos += comment.nickname.length + 2;
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%@", comment.reply_user_id] range:NSMakeRange(localPos, comment.reply_nickname.length)];
        }
        
        [commentStrArray addObject:commentStr];
    }
    
    return commentStrArray;
}

+(CGFloat)getHeight:(NSArray *)array maxWidth:(CGFloat)maxWidth
{
    if (array.count == 0) {
        return 0;
    }
    
    CGFloat height = TopMargin;
    
    if (array.count > 0) {
        
        CGFloat width = maxWidth;
        
        NSMutableArray *commentStrArray = [self genCommentAttrString:array];
        
        for (NSMutableAttributedString *str in commentStrArray) {
            CGSize textSize = [MLLinkLabel getViewSize:str maxWidth:width font:CommentLabelFont lineHeight:CommentLabelLineHeight lines:0];
            height+= textSize.height;
        }
    }
    return height;
}

-(MLClickColorLinkLabel *) createLinkLabel
{
    
    MLClickColorLinkLabel *lable = [[MLClickColorLinkLabel alloc] initWithFrame:CGRectZero];
    //    lable.clickDelegate = self;
    //
    //    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    //    [lable addGestureRecognizer:longPress];
    //
    //    lable.tag = LinkLabelTag;
    
    
    lable.font = CommentLabelFont;
    lable.numberOfLines = 0;
    lable.adjustsFontSizeToFitWidth = NO;
    lable.textInsets = UIEdgeInsetsZero;
    //
    lable.dataDetectorTypes = MLDataDetectorTypeAll;
    lable.allowLineBreakInsideLinks = NO;
    lable.linkTextAttributes = nil;
    lable.activeLinkTextAttributes = nil;
    lable.lineHeightMultiple = CommentLabelLineHeight;
    //    lable.linkTextAttributes = @{NSForegroundColorAttributeName: HighLightTextColor};
    
    __block CommentView *blockself = self;
    
    [lable setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
        
        if (_delegate != nil && [_delegate respondsToSelector:@selector(clickLabel:)]) {
            
            NSUInteger userId = [link.linkValue integerValue];
            [blockself.delegate clickLabel:userId];
        }
    }];
    
    
    return lable;
    
}



@end

