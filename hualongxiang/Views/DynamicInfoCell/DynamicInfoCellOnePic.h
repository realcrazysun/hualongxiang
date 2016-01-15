//
//  DynamicInfoCellOnePic.h
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicInfoCellOnePic : UITableViewCell
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* readcountLabel;
@property(nonatomic,strong)UIImageView* imgView;
-(void)setImgUrl:(NSString *)urlString;
@end
