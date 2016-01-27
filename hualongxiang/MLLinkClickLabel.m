//
//  MLLinkClickLabel.m
//  DFCommon
//
//  Created by Allen Zhong on 15/10/10.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "MLLinkClickLabel.h"

@implementation MLLinkClickLabel


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//        [self addGestureRecognizer:longPress];
    }
    return self;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    MLLink *link = [self linkAtPoint:[touch locationInView:self]];
    if (!link) {
        if (_clickDelegate && [_clickDelegate respondsToSelector:@selector(onClickOutsideLink:)]) {
            [_clickDelegate onClickOutsideLink:_uniqueId];
        }
    }
    
}

@end
