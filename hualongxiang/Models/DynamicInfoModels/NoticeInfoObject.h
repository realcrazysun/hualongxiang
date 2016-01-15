//
//  NoticeInfoObject.h
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

//所有信息
@class NoticeListInfoObject;
#import <Foundation/Foundation.h>
@interface NoticeInfoObject : NSObject
@property (copy, nonatomic,readonly) NSString * last_side_id;
@property (copy, nonatomic,readonly) NSString * last_post_id;
@property (copy, nonatomic,readonly) NSString * update_num;
@property (copy, nonatomic,readonly) NSString * has_unread_hot;
@property (copy, nonatomic,readonly) NSArray  * list;
@end

@interface NoticeListInfoObject : NSObject
@property (copy, nonatomic,readonly) NSString * type;
@property (copy, nonatomic,readonly) NSString * from_id;
@property (copy, nonatomic,readonly) NSString * from_name;
@property (copy, nonatomic,readonly) NSString * target_id;
@property (copy, nonatomic,readonly) NSString * title;
@property (copy, nonatomic,readonly) NSString * url;
@property (copy, nonatomic,readonly) NSString * cover;
@property (copy, nonatomic,readonly) NSString * source_id;
@property (copy, nonatomic,readonly) NSString * source;
@property (copy, nonatomic,readonly) NSString * attaches_num;
@property (copy, nonatomic,readonly) NSString * likes_num;
@property (copy, nonatomic,readonly) NSString * views_num;
@property (copy, nonatomic,readonly) NSString * replies_num;
@property (copy, nonatomic,readonly) NSString * post_num;
@property (copy, nonatomic,readonly) NSString * person_num;
@property (copy, nonatomic,readonly) NSString * reason;
@property (copy, nonatomic,readonly) NSString * author_id;
@property (copy, nonatomic,readonly) NSString * author;
@property (copy, nonatomic,readonly) NSString * gender;
@property (copy, nonatomic,readonly) NSString * vip_id;
@property (copy, nonatomic,readonly) NSString * avatar;
@property (copy, nonatomic,readonly) NSString * push_at;
@property (copy, nonatomic,readonly) NSString * push_num;
@property (copy, nonatomic,readonly) NSString * title_type;
@property (copy, nonatomic,readonly) NSString * description;
@property (copy, nonatomic,readonly) NSString * vipid;
@property (copy, nonatomic,readonly) NSString * sort;
@property (copy, nonatomic,readonly) NSString * threadtype;
@property (copy, nonatomic,readonly) NSString * isfriend;
@property (copy, nonatomic,readonly) NSString * show_type;
@property (copy, nonatomic,readonly) NSString * to_type;

@property (copy, nonatomic,readonly) NSArray  * attaches;
@end
