//
//  DiscoverItemModel.h
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverItemModel : NSObject
@property (copy, nonatomic) NSString * modelId; //对应id
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *cover;
@property (copy, nonatomic) NSString *belong_type;
@property (copy, nonatomic) NSString *belong_id;
@property (copy, nonatomic) NSString *show_model;

//id": 121,
//"name": "封面女神",
//"url": "http://app.qianfanyun.com/vote_invite/web/wap/default/list?aid=147",
//"cover": "http://7xilx2.com1.z0.glb.clouddn.com/_20151228175035_568105ebf1e31.png",
//"belong_type": 3,
//"belong_id": 0,
//"show_model": 0
@end
