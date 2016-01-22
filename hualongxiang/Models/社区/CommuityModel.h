//
//  CommuityModel.h
//  hualongxiang
//  文件名拼错了~~~~
//  Created by polyent on 16/1/15.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommuityModel : NSObject
@property (copy, nonatomic,readonly) NSArray  * attention;
@property (copy, nonatomic,readonly) NSArray  * recommend;
@end

@interface CommuityBlockModel : NSObject
@property (copy, nonatomic,readonly) NSString  * fid;
@property (copy, nonatomic,readonly) NSString  * name;
@property (copy, nonatomic,readonly) NSString  * logo;
@end