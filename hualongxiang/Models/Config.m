//
//  Config.m
//  iosapp
//
//  Created by chenhaoxiang on 11/6/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "Config.h"


//#import <SSKeychain.h>

NSString * const kUsername = @"username";
NSString * const kFaceurl = @"faceurl";
NSString * const kCcover = @"cover";
NSString * const kGender = @"gender";
NSString * const kPhone = @"phone";
NSString * const kSign = @"sign";
NSString * const kBirthday = @"birthday";
NSString * const kEmail = @"email";

NSString * const kRvrc = @"rvrc";
NSString * const kMoney = @"money";


NSString * const kLevel = @"level";
NSString * const kEasemob = @"easemob";
NSString * const kFollows = @"follows";
NSString * const kFans = @"fans";
NSString * const kVipid = @"vipid";
NSString * const kBbscookiename = @"bbscookiename";
NSString * const kBbscookievalue = @"bbscookievalue";
NSString * const kAllowpush = @"allowpush";
NSString * const kLogin_token = @"login_token";
NSString * const kUid = @"uid";
NSString * const kThird_app_token = @"third_app_token";
NSString * const kNickname = @"nickname";
NSString * const kBbstoken = @"bbstoken";

@implementation Config

#pragma mark - user profile

+ (void)saveProfile:(User *)user
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:user.username       forKey:kUsername];
    [userDefaults setObject:user.login_token    forKey:kLogin_token];
    [userDefaults setInteger:user.rvrc          forKey:kRvrc];
    [userDefaults setInteger:user.money         forKey:kMoney];
    [userDefaults setObject:user.sign           forKey:kSign];
    [userDefaults setObject:user.faceurl           forKey:kFaceurl];
    [userDefaults synchronize];
}


+ (void)clearProfile
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:@"" forKey:kUsername];
    [userDefaults setObject:@"" forKey:kLogin_token];
    [userDefaults setObject:@(0) forKey:kRvrc];
    [userDefaults setObject:@(0) forKey:kMoney];
    [userDefaults setObject:@"" forKey:kSign];
    [userDefaults setObject:@"" forKey:kFaceurl];
    [userDefaults synchronize];
}

+ (User *)myProfile
{
    User *user = [User new];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    user.username = [userDefaults objectForKey:kUsername];
    if ([user.username isEqualToString:@""]) {
        return nil;
    }
    user.login_token = [userDefaults objectForKey:kLogin_token] ;
    user.rvrc = [[userDefaults objectForKey:kRvrc] intValue];
    user.money = [[userDefaults objectForKey:kMoney] intValue];
    user.sign = [userDefaults objectForKey:kSign] ;
    user.faceurl = [userDefaults objectForKey:kFaceurl] ;
    return user;
}



+ (void)clearCookie
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"sessionCookies"];
}


+(NSString*)userIconUrl{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:kFaceurl] ;
}
@end
