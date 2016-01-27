//
//  ChatTableViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/25.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "CommonDefines.h"
@interface ChatTableViewCell()
@property(nonatomic,strong)UILabel* timeLabel;
@end
@implementation ChatTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-120, 15, 120, 15)];
        [self addSubview:_timeLabel];
    }
    return self;
}
-(void)setData:(NSString*)imgUrl title:(NSString*)title subTitle:(NSString*)subTitle time:(NSString*)time{
    self.imageView.image = [UIImage imageNamed:imgUrl];
    self.textLabel.text = title;
    self.detailTextLabel.text = subTitle;
    _timeLabel.text = time;
}
@end
