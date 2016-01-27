//
//  RightMenuCell.h
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Forum.h"
@interface RightMenuCell : UITableViewCell
@property(nonatomic)Subforum* data;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
