//
//  EditViewWithGrowingText.m
//  hualongxiang
//
//  Created by polyent on 16/1/29.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "EditViewWithGrowingText.h"
#import "UIView+Util.h"
@implementation EditViewWithGrowingText
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth; 
        _textView = [[GrowingTextView alloc] initWithPlaceholder:@"回复楼主"];
        CGFloat _textViewX = CGRectGetMaxX(self.emojiIcon.frame)+5;
        _textView.frame = CGRectMake(_textViewX , 10, frame.size.width-5-_textViewX, 30);
        [_textView setCornerRadius:4];
        [_textView setBorderWidth:1 andColor:[UIColor lightGrayColor]];
        [self addSubview:_textView];
    }
    return self;
}
@end
