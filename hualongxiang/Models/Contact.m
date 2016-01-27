//
//  Contact.m
//  hualongxiang
//  
//  Created by polyent on 16/1/25.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "Contact.h"
#import "MJExtension.h"
@implementation Contact
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"fixed" : @"FixedContact",
             @"list" : @"DyContactList",
             };
}
@end

@implementation FixedContact



@end
@implementation DyContactList
+ (NSDictionary *)objectClassInArray
{
    return @{
                @"list" : @"DyContact",
             };
}


@end

@implementation DyContact



@end