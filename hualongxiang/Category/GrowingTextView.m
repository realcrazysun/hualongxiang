//
//  GrowingTextView.m
//  iosapp
//
//  Created by ChanAetern on 11/17/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "GrowingTextView.h"

@implementation GrowingTextView

- (instancetype)initWithPlaceholder:(NSString *)placeholder
{
    self = [super init];
    if (self) {
        self.placeholder = placeholder;
        self.font = [UIFont systemFontOfSize:16];
        self.scrollEnabled = NO;
        self.scrollsToTop = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.enablesReturnKeyAutomatically = YES;
        self.textContainerInset = UIEdgeInsetsMake(7.5, 3.5, 7.5, 0);
        _maxNumberOfLines = 4;
        _maxHeight = ceilf(self.font.lineHeight * _maxNumberOfLines + 15 + 4 * (_maxNumberOfLines - 1));
    }
    
    return self;
}

// Code from apple developer forum - @Steve Krulewitz, @Mark Marszal, @Eric Silverberg
- (CGFloat)measureHeight
{
    return ceilf([self sizeThatFits:self.frame.size].height + 15);
}


@end
