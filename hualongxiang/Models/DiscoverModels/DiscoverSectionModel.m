//
//  DiscoverSectionModel.m
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "DiscoverSectionModel.h"
#import "DiscoverItemModel.h"
@implementation DiscoverSectionModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"val" : @"DiscoverItemModel",
             };
}
@end
