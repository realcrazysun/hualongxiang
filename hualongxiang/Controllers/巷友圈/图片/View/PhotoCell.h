//
//  PhotoCell.h
//  新闻
//
//  Created by gyh on 15/9/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HotRecommend;
@interface PhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *smallIcon;
@property (strong, nonatomic) IBOutlet UIView *likeView;
@property (strong, nonatomic) IBOutlet UIImageView *likeImg;
@property (strong, nonatomic) IBOutlet UILabel *likeNumLabel;

@property (nonatomic , strong) HotRecommend *photo;

@end
