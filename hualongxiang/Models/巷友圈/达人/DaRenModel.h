//
//  DaRenModel.h
//  hualongxiang
//
//  Created by polyent on 16/1/29.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaRenModel : NSObject
@property (assign, nonatomic,readonly)  NSInteger   user_id;
@property (copy, nonatomic,readonly)    NSString    * user_name;
@property (assign, nonatomic,readonly)  NSInteger   user_vip;
@property (copy, nonatomic,readonly)    NSString    * user_icon;
@property (assign, nonatomic,readonly)  NSInteger   user_gender;
@property (copy, nonatomic,readonly)    NSString    * user_sign_message;
@property (copy, nonatomic,readonly)    NSString    * num_str;
@property (copy, nonatomic,readonly)    NSArray     * img;
@property (assign, nonatomic,readonly)  NSInteger   is_followed;

//"user_id": 2237472,
//"user_name": "原来什么都不要",
//"user_vip": 0,
//"user_icon": "http://pic.hualongxiang.com/attachment/upload/middle/72/2237472.jpg",
//"user_gender": 2,
//"user_sign_message": "我是你想不到的无关痛痒",
//"num_str": "今日被赞43次 | 2张图片",
//"img": ["http://7xilx2.com1.z0.glb.clouddn.com/20160128_2237472_1453968683412.jpg?imageView2/1/w/150/h/150/interlace/1/q/100", "http://7xilx2.com1.z0.glb.clouddn.com/20160121_2237472_1453383263696.jpg?imageView2/1/w/150/h/150/interlace/1/q/100", "http://7xilx2.com1.z0.glb.clouddn.com/20160116_2237472_1452952446394.jpg?imageView2/1/w/150/h/150/interlace/1/q/100", "http://7xilx2.com1.z0.glb.clouddn.com/20160115_2237472_1452809397281.jpg?imageView2/1/w/150/h/150/interlace/1/q/100"],
//"is_followed": 0

@end
