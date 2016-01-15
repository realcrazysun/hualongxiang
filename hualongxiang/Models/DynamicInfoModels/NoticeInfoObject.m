//
//  NoticeInfoObject.m
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "NoticeInfoObject.h"

@implementation NoticeInfoObject

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"list" : @"NoticeListInfoObject",
             };
}

@end

@implementation NoticeListInfoObject

-(BOOL)isEqual:(id)object{
    return NO;
}
@end
