//
//  RecommendObject.h
//  hualongxiang
//
//  Created by polyent on 16/1/17.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendObject : NSObject
//top_ad": [],
//"topics": [],
//"users": [],
//bar": [{
//list": [{
//"hot_bar": 1
@property (copy, nonatomic,readonly) NSArray  * top_ad;
@property (copy, nonatomic,readonly) NSArray  * topics;
@property (copy, nonatomic,readonly) NSArray  * users;
@property (copy, nonatomic,readonly) NSArray  * bar;
@property (copy, nonatomic,readonly) NSArray  * list;
@property (copy, nonatomic,readonly) NSString * hot_bar;

@end

@interface TodayHot : NSObject
@property (copy, nonatomic,readonly) NSString  * hotId;
@property (copy, nonatomic,readonly) NSString  * user_id;
@property (copy, nonatomic,readonly) NSString  * nickname;
@property (copy, nonatomic,readonly) NSString  * avatar;
@property (copy, nonatomic,readonly) NSString  * content;
@property (copy, nonatomic,readonly) NSString  * cover;
@end

@interface NewPost : NSObject
@property (copy, nonatomic,readonly) NSString  * postId;
@property (copy, nonatomic,readonly) NSString  * user_id;
@property (copy, nonatomic,readonly) NSString  * nickname;
@property (copy, nonatomic,readonly) NSString  * avatar;
@property (copy, nonatomic,readonly) NSString  * vip;
@property (copy, nonatomic,readonly) NSString  * gender;
@property (copy, nonatomic,readonly) NSString  * content;
@property (copy, nonatomic,readonly) NSString  * reason;
@property (copy, nonatomic,readonly) NSString  * address;
@property (copy, nonatomic,readonly) NSString  * share_url;
@property (copy, nonatomic,readonly) NSString  * share_img;
@property (copy, nonatomic,readonly) NSArray   * attaches;
@property (copy, nonatomic,readonly) NSString  * like_num;
@property (copy, nonatomic,readonly) NSArray   * likes;
@property (copy, nonatomic,readonly) NSString  * reply_num;
@property (copy, nonatomic,readonly) NSArray   * replies;
@property (copy, nonatomic,readonly) NSString  * created_at;
@property (copy, nonatomic,readonly) NSString  * is_liked;
@end

@interface ReplyObject : NSObject
@property (copy, nonatomic,readonly) NSString  * replyId;
@property (copy, nonatomic,readonly) NSString  * user_id;
@property (copy, nonatomic,readonly) NSString  * nickname;
@property (copy, nonatomic,readonly) NSString  * content;
@property (copy, nonatomic,readonly) NSString  * reply_user_id;
@property (copy, nonatomic,readonly) NSString  * reply_nickname;
@end

