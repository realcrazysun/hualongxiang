//
//  HotThread.h
//  hualongxiang
//
//  Created by polyent on 16/2/18.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotThread : NSObject

@property (copy, nonatomic,readonly) NSString  * tid;
@property (copy, nonatomic,readonly) NSString  * subject;
@property (copy, nonatomic,readonly) NSString  * authorid;
@property (copy, nonatomic,readonly) NSString  * author;
@property (copy, nonatomic,readonly) NSString  * authoricon;
@property (copy, nonatomic,readonly) NSString  * fid;
@property (copy, nonatomic,readonly) NSString  * forumname;
@property (copy, nonatomic,readonly) NSString  * hits;
@property (copy, nonatomic,readonly) NSString  * replies;
@property (copy, nonatomic,readonly) NSString  * postdate;
@property (copy, nonatomic,readonly) NSString  * lastpost;
@property (assign, nonatomic,readonly) NSUInteger   attnum;
@property (copy, nonatomic,readonly) NSArray   * imgs;
@end
