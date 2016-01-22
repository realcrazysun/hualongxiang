//
//  UIImageView+Util.m
//  iosapp
//
//  Created by chenhaoxiang on 11/11/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "UIImageView+Util.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Util)

- (void)loadPortrait:(NSURL *)portraitURL
{
    [self sd_setImageWithURL:portraitURL placeholderImage:[UIImage imageNamed:@"default-portrait"] options:0];
}

- (void)loadPortraitWithNSString:(NSString *)portraitURL
{
    NSURL * url = [NSURL URLWithString:portraitURL];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default-portrait"] options:0];
}
- (void)loadPortraitWithNSString:(NSString *)portraitURL defaultImgString:(NSString*)defaultImgString{
    NSURL * url = [NSURL URLWithString:portraitURL];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:defaultImgString] options:0];
}
@end
