//
//  HotInfoModel.h
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class HotInfoItemModel;
@class HotInfoHeadModel;
@interface HotInfoModel : NSObject
@property (copy, nonatomic,readonly) NSString * pushtime;
@property (copy, nonatomic,readonly) HotInfoItemModel * items;
@end

@interface HotInfoItemModel : NSObject
@property (copy, nonatomic,readonly) HotInfoHeadModel * header;
@property (copy, nonatomic,readonly) NSArray * body;
@end

@interface HotInfoHeadModel : NSObject
@property (copy, nonatomic,readonly) NSString * type;
@property (copy, nonatomic,readonly) NSString * dataid;
@property (copy, nonatomic,readonly) NSString * replaceTitle;
@property (copy, nonatomic,readonly) NSString * url;
@property (copy, nonatomic,readonly) NSString  * cover;
@end

@interface HotInfoBodyModel : NSObject
@property (copy, nonatomic,readonly) NSString * type;
@property (copy, nonatomic,readonly) NSString * dataid;
@property (copy, nonatomic,readonly) NSString * replaceTitle;
@property (copy, nonatomic,readonly) NSString * url;
@property (copy, nonatomic,readonly) NSString * cover;
@end