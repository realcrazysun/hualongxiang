//
//  DaRenTableViewCell.h
//  hualongxiang
//
//  Created by polyent on 16/1/28.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaRenModel.h"
@interface DaRenTableViewCell : UITableViewCell
+(CGFloat)getCellHeight;
-(void)setData:(DaRenModel*) data;
-(void)setRankImg:(NSString*)imgName;
@end
