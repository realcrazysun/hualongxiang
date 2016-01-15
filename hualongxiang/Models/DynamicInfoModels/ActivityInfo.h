//
//  ActivityInfo.h
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityInfo : NSObject
@property (copy, nonatomic,readonly) NSString * modelId;
@property (copy, nonatomic,readonly) NSString * name;
@property (copy, nonatomic,readonly) NSString * belong_type;
@property (copy, nonatomic,readonly) NSString * belong_id;
@property (copy, nonatomic,readonly) NSString * start_time;
@property (copy, nonatomic,readonly) NSString * end_time;
@property (copy, nonatomic,readonly) NSString * url;
@property (copy, nonatomic,readonly) NSString * cover;
@property (copy, nonatomic,readonly) NSString * status;
@end
