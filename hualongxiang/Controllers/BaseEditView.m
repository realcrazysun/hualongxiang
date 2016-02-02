//
//  BaseEditView.m
//  hualongxiang
//
//  Created by polyent on 16/1/29.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "BaseEditView.h"
#import "UIColor+Wonderful.h"
@implementation BaseEditView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteSmoke];
        _imgIcon = [[UIImageView alloc ] initWithFrame:CGRectMake(5, 10, 30, 30)];
        _imgIcon.image = [UIImage imageNamed:@"chatBar_more_photo"];
        [self addSubview:_imgIcon];
        
        _emojiIcon = [[UIImageView alloc ] initWithFrame:CGRectMake(CGRectGetMaxX(_imgIcon.frame)+5, 10, 30, 30)];
        _emojiIcon.image = [UIImage imageNamed:@"2"];
        [self addSubview:_emojiIcon];

    }
    return self;
}
@end
