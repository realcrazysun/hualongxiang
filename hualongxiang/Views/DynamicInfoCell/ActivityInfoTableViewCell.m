//
//  ActivityInfoTableViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "ActivityInfoTableViewCell.h"
#import "UIImageView+Util.h"
#import "UIColor+Wonderful.h"
@implementation ActivityInfoTableViewCell
-(void)setModel:(ActivityInfo*)info{
    _title.text = info.name;
    _timeLabel.text = [NSString stringWithFormat:@"%@~%@", info.start_time,info.end_time];
    NSURL* url = [NSURL URLWithString:info.cover];
    [_image loadPortrait:url];
//    _indicatorLabel.transform = CGAffineTransformMakeRotation(M_PI/4);
    _indicatorLabel.layer.masksToBounds = YES;
    if([info.status isEqualToString:@"1"]){
        _indicatorLabel.text = @"进行中";
        _indicatorLabel.backgroundColor = [UIColor mediumTurquoise];
    }else{
        _indicatorLabel.text = @"已结束";
        _indicatorLabel.backgroundColor = [UIColor grayColor];
    }
     _indicatorLabel.alpha = 1;
}
@end
