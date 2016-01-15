//
//  DiscoverViewCell.h
//  hualongxiang
//
//  Created by polyent on 16/1/10.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverViewCell : UICollectionViewCell
@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *text;
-(void)setImgUrl:(NSString*)urlString;
@end
