//
//  ResponseRootObject.h
//  hualongxiang
//
//  Created by polyent on 16/1/12.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface ResponseRootObject : NSObject
@property (strong, nonatomic) id data;
@property (copy, nonatomic) NSString *ret;
@property (copy, nonatomic) NSString *text;
@end
