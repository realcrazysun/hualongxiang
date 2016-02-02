//
//  HotRecommend.h
//  hualongxiang
//
//  Created by polyent on 16/2/2.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotRecommend : NSObject
//{
//    "id": 171772,
//    "user_id": 1612467,
//    "nickname": "jiangniuniu",
//    "avatar": "http://pic.hualongxiang.com/attachment/upload/middle/67/1612467.jpg",
//    "vip": 0,
//    "gender": 2,
//    "is_liked": 0,
//    "created_at": "昨天 18:49",
//    "cover": {
//        "width": 750,
//        "height": 560,
//        "type": 0,
//        "url": "http://7xilx2.com1.z0.glb.clouddn.com/2016020116124671454323798651602.jpg?imageView2/1/w/420/h/314/interlace/1/q/100"
//    },
//    "like_num": 44
//}
@property (copy, nonatomic,readonly) NSString  * modelId;
@property (copy, nonatomic,readonly) NSString  * user_id;
@property (copy, nonatomic,readonly) NSString  * nickname;
@property (copy, nonatomic,readonly) NSString  * avatar;
@property (copy, nonatomic,readonly) NSString  * vip;
@property (copy, nonatomic,readonly) NSString  * gender;
@property (copy, nonatomic,readonly) NSString  * is_liked;
@property (copy, nonatomic,readonly) NSString  * created_at;
@property (copy, nonatomic,readonly) NSDictionary  * cover;
@property (copy, nonatomic,readonly) NSString  * like_num;
@end
