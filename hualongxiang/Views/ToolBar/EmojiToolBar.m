//
//  EmojiToolBar.m
//  hualongxiang
//
//  Created by polyent on 16/1/25.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "EmojiToolBar.h"

@implementation EmojiToolBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_emojiButton];
    }
    return self;
}
@end
