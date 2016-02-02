//
//  NearByUser.h
//  hualongxiang
//
//  Created by polyent on 16/1/28.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearByUser : NSObject
//{
//    "ret": 0,
//    "text": "",
//    "data": [{
//        "user_id": 2429951,
//        "user_name": "落叶星辰★",
//        "user_vip": 0,
//        "user_icon": "http://pic.hualongxiang.com/images/face/none.gif",
//        "user_gender": 1,
//        "user_sign_message": "",
//        "num_str": "被赞0次 | 0张图片",
//        "img": [],
//        "near_last_time": "3天前",
//        "near_distance": "112m"
//    }
@property (assign, nonatomic,readonly)  NSInteger   user_id;
@property (copy, nonatomic,readonly)    NSString    * user_name;
@property (assign, nonatomic,readonly)  NSInteger   user_vip;
@property (copy, nonatomic,readonly)    NSString    * user_icon;
@property (assign, nonatomic,readonly)  NSInteger   user_gender;
@property (copy, nonatomic,readonly)    NSString    * user_sign_message;
@property (copy, nonatomic,readonly)    NSString    * num_str;
@property (copy, nonatomic,readonly)    NSArray     * img;
@property (copy, nonatomic,readonly)    NSString    * near_last_time;
@property (copy, nonatomic,readonly)    NSString    * near_distance;
@end
