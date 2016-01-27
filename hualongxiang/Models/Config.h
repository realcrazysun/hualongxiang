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
+(NSMutableArray*)loadSearchHistory;//加载搜索历史
+(void)addSearchHistory:(NSString*)searchInfo;
+(void)clearSearchHistory;
+(int64_t)getOwnID;
@end
