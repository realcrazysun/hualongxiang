//
//  RecommendObject.m
//  hualongxiang
//
//  Created by polyent on 16/1/17.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "RecommendObject.h"
#import "MJExtension.h"
@implementation RecommendObject
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"bar" : @"TodayHot",
             @"list" : @"NewPost",
             };
}

@end

@implementation TodayHot
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"hotId" : @"id"};
}
@end

@implementation NewPost
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"postId" : @"id"};
}
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"replies" : @"ReplyObject",
             };
}
@end
@implementation ReplyObject

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"replyId" : @"id"};
}

@end