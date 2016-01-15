//
//  DynamicInfoCellThreePic.h
//  hualongxiang
//  两张或三张图片
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicInfoCellThreePic : UITableViewCell
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* readcountLabel;
@property(nonatomic,strong)UILabel* timeLabel;
@property(nonatomic,strong)UIImageView* viewForImg;
-(void)setImgArr:(NSArray*)arr;
@end
