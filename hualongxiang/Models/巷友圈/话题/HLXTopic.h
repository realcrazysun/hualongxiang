//
//  HLXTopic.h
//  hualongxiang
//
//  Created by polyent on 16/1/16.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLXTopic : NSObject
//"id": 19,
//"name": "心情日志",
//"icon": "http://7xilx2.com1.z0.glb.clouddn.com/2016011623657491452929097053532.jpg?imageView2/1/w/150/h/150/interlace/1/q/100",
//"num_str": "已有46667人参与 · 80204张照片"

@property (copy, nonatomic,readonly) NSString  * modelId;
@property (copy, nonatomic,readonly) NSString  * name;
@property (copy, nonatomic,readonly) NSString  * icon;
@property (copy, nonatomic,readonly) NSString  * num_str;
@end
