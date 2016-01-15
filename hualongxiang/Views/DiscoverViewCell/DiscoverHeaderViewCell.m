//
//  DiscoverHeaderViewCell.m
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DiscoverHeaderViewCell.h"
#import "UIColor+Wonderful.h"
@implementation DiscoverHeaderViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor gainsboroColor];

        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame)-10, 20)];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.textLabel];
    }
    return self;
}

@end
