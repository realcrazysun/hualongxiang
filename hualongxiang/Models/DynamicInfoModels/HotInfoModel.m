//
//  HotInfoModel.m
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HotInfoModel.h"

@implementation HotInfoModel

-(BOOL)isEqual:(id)object{
    return NO;
}
@end

@implementation  HotInfoItemModel
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"body" : @"HotInfoBodyModel",
             };
}
@end
@implementation HotInfoHeadModel

+ (NSDictionary *)replacedKeyFromPropertyName

{
    
    return @{@"replaceTitle" : @"new_title"};
    
}

@end

@implementation HotInfoBodyModel
+ (NSDictionary *)replacedKeyFromPropertyName

{
    
    return @{@"replaceTitle" : @"new_title"};
    
}


@end