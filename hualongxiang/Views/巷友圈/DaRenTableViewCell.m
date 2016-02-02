//
//  DaRenTableViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/28.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DaRenTableViewCell.h"
#import "CommonDefines.h"
#import "UIView+Util.h"
#import "UIImageView+Util.h"
#import "UIColor+Wonderful.h"
#define NameLabelFont [UIFont systemFontOfSize:14]
@interface DaRenTableViewCell()
@property(nonatomic,strong)UIImageView* rankImgView;//排名
@property(nonatomic,strong)UIImageView* userIcon;
@property(nonatomic,strong)UIImageView* vipView;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UIImageView* genderView;
@property(nonatomic,strong)UILabel* desLabel;
@property(nonatomic,strong)UIButton* noticeBtn;
@property(nonatomic,strong)NSMutableArray* pics;
@property(nonatomic,strong)DaRenModel* data;
@end
@implementation DaRenTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}
-(void)initSubViews{
    _rankImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.contentView addSubview:_rankImgView];
    
    _userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 30, 30)];
    [_userIcon setCornerRadius:15];
    [self.contentView addSubview:_userIcon];
    
    //    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userIcon.frame)+5, 12, 0, 15)];
    _nameLabel = [UILabel new];
    _nameLabel.font = NameLabelFont;
    [self.contentView addSubview:_nameLabel];
    
    _desLabel = [UILabel new];
    _desLabel.font = [UIFont systemFontOfSize:12];
    _desLabel.alpha = 0.5;
    [self.contentView addSubview:_desLabel];
    
    _genderView = [UIImageView new];
    [self.contentView addSubview:_genderView];
    
    _noticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _noticeBtn.frame = CGRectMake(ScreenWidth-10-60, 12, 60, 25);
    [_noticeBtn setCornerRadius:4];
    [self.contentView addSubview:_noticeBtn];
    
    CGFloat picW = [DaRenTableViewCell getPicWidth];
    CGFloat margin = (ScreenWidth - 20 - 4*picW)/3;
    

    _pics = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        UIImageView* pic = [UIImageView new];
               pic.frame = CGRectMake(10+(picW+margin)*i, 60, picW, picW);
        [_pics addObject:pic];
        [self.contentView addSubview:pic];
    }
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 60 + picW +5, ScreenWidth, 15)];
    view.backgroundColor = [UIColor whiteSmoke];
    view.alpha = 0.8;
    [self.contentView addSubview:view];
}
-(void)setData:(DaRenModel*) data{
    _data = data;
    [_userIcon loadPortraitWithNSString:data.user_icon];
    CGSize titleSize = [data.user_name sizeWithAttributes:@{NSFontAttributeName:NameLabelFont}];;
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_userIcon.frame)+5, 12, titleSize.width, 15);
    _nameLabel.text = data.user_name;
    
    _desLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame)+5, 200, 15);
    _desLabel.text = data.num_str;

    _genderView.frame =  CGRectMake(CGRectGetMaxX(_nameLabel.frame)+2, CGRectGetMaxY(_nameLabel.frame) - 15, 15, 15);
    if (data.user_gender == 0) {
        _genderView.image = [UIImage imageNamed:@"userinfo_gender_female"];
        
    }else{
        _genderView.image = [UIImage imageNamed:@"userinfo_gender_male"];
    }
    
    if (data.is_followed == 0) {
        [_noticeBtn setImage:[UIImage imageNamed:@"btn_followbg_normal"] forState:UIControlStateNormal];
//        [_noticeBtn setTitle:@"关注" forState:UIControlStateNormal];
//        [_noticeBtn setTitleColor:[UIColor seaGreen] forState:UIControlStateNormal];
//        [_noticeBtn setBorderWidth:1 andColor:[UIColor seaGreen]];
    }else{
        [_noticeBtn setImage:[UIImage imageNamed:@"btn_chatbg_normal"] forState:UIControlStateNormal];
//        [_noticeBtn setTitle:@"聊天" forState:UIControlStateNormal];
//        [_noticeBtn setTitleColor:[UIColor chocolateColor] forState:UIControlStateNormal];
//        [_noticeBtn setBorderWidth:1 andColor:[UIColor chocolateColor]];
    }
    
    for(int i = 0; i < _pics.count; i++){
        UIImageView* imageView = _pics[i];
        [imageView loadPortrait:data.img[i]];
    }
    }

-(void)setRankImg:(NSString*)imgName{
    _rankImgView.image = [UIImage imageNamed:imgName];
}


//cell 高度
+(CGFloat)getCellHeight{
    return 60 + [DaRenTableViewCell getPicWidth] +20;
}
+(CGFloat)getPicWidth{
    if (ScreenWidth>320) {
        return 80;
    }
    return 70;
}
@end
