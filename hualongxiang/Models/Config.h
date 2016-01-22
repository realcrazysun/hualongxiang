//
//  Config.h
//  iosapp
//
//  Created by chenhaoxiang on 11/6/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

@interface Config : NSObject

+ (void)saveProfile:(User *)user;
//+ (void)updateProfile:(User *)user;
+ (void)clearProfile;
+ (User *)myProfile;
+ (NSString *)userIconUrl;
@end