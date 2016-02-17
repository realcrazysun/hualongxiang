//
//  UserInfo.h
//  hualongxiang
//
//  Created by polyent on 16/2/15.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (assign, nonatomic,readonly)  NSInteger   uid;
@property (copy, nonatomic,readonly)    NSString    * username;
@property (assign, nonatomic,readonly)  NSString    * level;
@property (assign, nonatomic,readonly)  NSInteger   gender;
@property (assign, nonatomic,readonly)  NSInteger   cover;
@property (assign, nonatomic,readonly)  NSInteger   rvrc;
@property (copy, nonatomic,readonly)    NSString    * faceurl;
@property (copy, nonatomic,readonly)    NSString    * sign;
@property (copy, nonatomic,readonly)    NSString    * phone;
@property (copy, nonatomic,readonly)    NSString    * email;
@property (assign, nonatomic,readonly)  NSInteger   postnum;
@property (copy, nonatomic,readonly)    NSString    * regdate;
@property (copy, nonatomic,readonly)    NSString    * onlinetime;
@property (copy, nonatomic,readonly)    NSString    * follows;
@property (copy, nonatomic,readonly)    NSString    * fans;
@property (copy, nonatomic,readonly)    NSString    * birthday;
@property (assign, nonatomic,readonly)  NSInteger   isattention;
@property (copy, nonatomic,readonly)    NSString    * share_title;
@property (copy, nonatomic,readonly)    NSString    * share_url;
@property (copy, nonatomic,readonly)    NSString    * share_content;
@property (copy, nonatomic,readonly)    NSString    * share_pic;
@property (copy, nonatomic,readonly)    NSString    * nickname;
@property (copy, nonatomic,readonly)    NSString    * avatar;
@end
