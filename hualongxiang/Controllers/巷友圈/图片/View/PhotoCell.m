//
//  PhotoCell.m
//  新闻
//
//  Created by gyh on 15/9/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PhotoCell.h"
#import "HotRecommend.h"
#import "UIImageView+WebCache.h"
#import "UIView+Util.h"

@implementation PhotoCell
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
       
    }
    return self;
}
-(void)setPhoto:(HotRecommend *)photo
{
    _photo = photo;
    
    //图片
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[photo.cover objectForKey:@"url"]] placeholderImage:nil];
    
    //文字
    self.titleLabel.text = photo.nickname;
    
    
    [self.smallIcon sd_setImageWithURL:[NSURL URLWithString:photo.avatar] placeholderImage:nil];
    [self.smallIcon setCornerRadius:self.smallIcon.frame.size.width/2];
    
    [self.likeView setCornerRadius:20];
    
    self.likeNumLabel.text = photo.like_num;
    self.likeImg.image = [[UIImage imageNamed:@"ic_to_like"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.likeImg setCornerRadius:12];
    if ([photo.is_liked isEqualToString:@"0"]) {
       
        self.likeImg.backgroundColor = [UIColor whiteColor];
    }else{
        self.likeImg.backgroundColor = [UIColor redColor];

    }
}
@end
