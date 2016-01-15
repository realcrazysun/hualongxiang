//
//  HotInfoTableViewCell.h
//  hualongxiang
//
//  Created by polyent on 16/1/13.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotInfoModel.h"
@class NewsView;
@interface HotInfoTableViewCell : UITableViewCell
//填充数据
-(void)setData:(NSString*)timeString
        header:(HotInfoHeadModel*)header
          news:(NSArray*)arr;
@end

@interface NewsView : UIView
@property(nonatomic,strong)UILabel* text;
@property(nonatomic,strong)UIImageView* imgView;
@end