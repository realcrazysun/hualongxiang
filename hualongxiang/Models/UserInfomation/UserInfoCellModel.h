//
//  UserInfoCellModel.h
//  hualongxiang
//
//  Created by polyent on 16/2/16.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoCellModel : NSObject
@property (assign, nonatomic,readonly)  NSInteger   aid;
@property (assign, nonatomic,readonly)  NSInteger   tid;
@property (assign, nonatomic,readonly)  NSInteger   source;
@property (assign, nonatomic,readonly)  NSInteger   fid;    
@property (copy, nonatomic,readonly)    NSString    * fname;
@property (copy, nonatomic,readonly)    NSString    * author;
@property (assign, nonatomic,readonly)  NSInteger   authorid;
@property (assign, nonatomic,readonly)  NSInteger   pingcount;

@property (assign, nonatomic,readonly)  NSInteger   gender;
@property (assign, nonatomic,readonly)  NSInteger   replies;
@property (assign, nonatomic,readonly)  NSInteger   degest;
@property (assign, nonatomic,readonly)  NSInteger   ifupload;
@property (assign, nonatomic,readonly)  NSInteger   topped;

@property (copy, nonatomic,readonly)    NSString    * subject;
@property (copy, nonatomic,readonly)    NSString    * dateline;
@property (copy, nonatomic,readonly)    NSString    * lastdate;
@property (copy, nonatomic,readonly)    NSString    * lastposter;
@property (copy, nonatomic,readonly)    NSString    * special;
@property (assign, nonatomic,readonly)  NSInteger   isfriend;
@property (assign, nonatomic,readonly)  NSInteger   vipid;

@property (copy, nonatomic,readonly)    NSString    * face;
@property (copy, nonatomic,readonly)    NSString    * typetitle;
@property (copy, nonatomic,readonly)    NSString    * content;

@property (copy, nonatomic,readonly)    NSArray    * imgs;

@property (copy, nonatomic,readonly)    NSString    * from_name;
@property (assign, nonatomic,readonly)  NSInteger   from_id;
@property (assign, nonatomic,readonly)  NSInteger   tmpSort;
@property (assign, nonatomic,readonly)  NSInteger   type;
@property (assign, nonatomic,readonly)  NSInteger   threadtype;


//"imgs": [{
//    "aid": 501292,
//    "attachurl": "http://7xilx2.com1.z0.glb.clouddn.com/20160117_2445630_1453033241599.jpg?imageView2/1/w/420/h/315/interlace/1/q/100",
//    "width": 420,
//    "height": 315
//}],
//"from_name": "有一种心情叫做______",
//"from_id": 19,
//"tmpSort": 1453033343,
//"type": 1,
//"threadtype": 0
@end
