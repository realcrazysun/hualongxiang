//
//  User.h
//  hualongxiang
//
//  Created by polyent on 16/1/21.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString *faceurl;
@property (nonatomic, assign) int cover;
@property (nonatomic, assign) int gender;
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* sign;
@property (nonatomic, copy) NSString* birthday;
@property (nonatomic, copy) NSString *email;

@property (nonatomic, assign) int rvrc;
@property (nonatomic, assign) int money;

@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *easemob;
@property (nonatomic, assign) int follows;
@property (nonatomic, assign) int fans;
@property (nonatomic, assign) int vipid;
@property (nonatomic, copy) NSString *bbscookiename;
@property (nonatomic, copy) NSString *bbscookievalue;
@property (nonatomic, assign) int allowpush;
@property (nonatomic, copy) NSString *login_token;
@property (nonatomic, assign) int uid;
@property (nonatomic, copy) NSString *third_app_token;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *bbstoken;
@end
