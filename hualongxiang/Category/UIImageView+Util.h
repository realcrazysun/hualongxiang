//
//  UIImageView+Util.h
//  iosapp
//
//  Created by chenhaoxiang on 11/11/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Util)

- (void)loadPortrait:(NSURL *)portraitURL;
- (void)loadPortraitWithNSString:(NSString *)portraitURL;
- (void)loadPortraitWithNSString:(NSString *)portraitURL defaultImgString:(NSString*)defaultImgString;
@end
