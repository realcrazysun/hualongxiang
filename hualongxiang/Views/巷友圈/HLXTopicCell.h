//
//  HLXTopicCell.h
//  hualongxiang
//
//  Created by polyent on 16/1/16.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLXTopic.h"
@interface HLXTopicCell : UITableViewCell
@property(nonatomic,strong)HLXTopic* model;
-(void)setModel:(HLXTopic*)topic;
@end
