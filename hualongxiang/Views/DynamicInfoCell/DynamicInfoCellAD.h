//
//  DynamicInfoCellAD.h
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicInfoCellAD : UITableViewCell
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UIImageView* imgView;
-(void)setImgUrl:(NSString *)urlString;
@end
