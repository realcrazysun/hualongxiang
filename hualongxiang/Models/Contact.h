//
//  Contact.h
//  hualongxiang
//  联系人
//  Created by polyent on 16/1/25.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
//fixed": [{
//"avatar": "http://pic.hualongxiang.com/attachment/upload/00/1025000_1450928498.jpg",
//"nickname": "化龙巷香香",
//"target_val": "1025000",
//"target_type": 0
//}, {
//    "avatar": "http://7xilx2.com1.z0.glb.clouddn.com/user/my_fan.png",
//    "nickname": "我的粉丝",
//    "target_val": "",
//    "target_type": 1
//}],
//"list": [{
//    "letter": "D",
//    "list": [{
//        "user_id": 2350934,
//        "avatar": "http://pic.hualongxiang.com/images/face/none.gif",
//        "nickname": "大孟子",
//        "is_friend": 0
//    }]
@property (copy, nonatomic,readonly) NSArray  * fixed;
@property (copy, nonatomic,readonly) NSArray  * list;
@end

@interface FixedContact : NSObject
@property (copy, nonatomic,readonly)    NSString  * avatar;
@property (copy, nonatomic,readonly)    NSString  * nickname;
@property (copy, nonatomic,readonly)    NSString  * target_val;
@property (assign, nonatomic,readonly)  NSUInteger  target_type;
@end

@interface DyContactList : NSObject
@property (copy, nonatomic,readonly)    NSString  * letter;
@property (copy, nonatomic,readonly)    NSArray  * list;
@end


@interface DyContact : NSObject
@property (assign, nonatomic,readonly)  NSUInteger user_id;
@property (copy, nonatomic,readonly)    NSString  * avatar;
@property (copy, nonatomic,readonly)    NSString  * nickname;
@property (assign, nonatomic,readonly)  NSUInteger is_friend;
@end