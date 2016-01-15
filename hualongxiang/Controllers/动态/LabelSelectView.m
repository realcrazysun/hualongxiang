//
//  LabelSelectView.m
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "LabelSelectView.h"

@implementation LabelSelectView
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSLog(@"init here");
        self.indicatorView.layer.cornerRadius = 2;
        self.indicatorView.layer.masksToBounds = YES;

    }
    return self;
}

@end
