//
//  Forum.m
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "Forum.h"
#import "MJExtension.h"
@implementation Forum
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"subforum" : @"Subforum",
             };
}
@end

@implementation Forums
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"forums" : @"Forum",
             };
}
@end

@implementation Subforum


@end