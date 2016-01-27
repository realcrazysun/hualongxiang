//
//  Forum.h
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forum : NSObject
//fid": 1004,
//"name": "聊常州",
//"showextra": 0,
//"subforum":
@property (nonatomic, assign,readonly) int      fid;
@property (nonatomic, copy,readonly) NSString*  name;
@property (nonatomic, assign,readonly) int      showextra;
@property (nonatomic, strong) NSMutableArray*  subforum;
@end

@interface Forums : NSObject
@property(nonatomic,strong)NSMutableArray* forums;
@end


@interface Subforum : NSObject
//fid": "103",
//"name": "龙城茶座",
//"logo": "http://hualongxiang.adm.qianfanyun.com/img/forum/1430116435_553dd853a9f79.jpg",
//"isfavor": 1,
//"tabsetting": [],
//"favors": "481525",
//"vieworder": "100",
//"subforum": []
@property (nonatomic, assign) int  fid; //在EditingViewController中作为承载model来使用了 感觉不是很应该  应该有其它更加合适的方法
@property (nonatomic, copy,readonly) NSString*  name;
@property (nonatomic, copy,readonly) NSString*  logo;
@property (nonatomic, assign,readonly) int      showextra;
@property (nonatomic, assign,readonly) int      isfavor;
@property (nonatomic, copy,readonly) NSArray*   tabsetting;
@property (nonatomic, copy,readonly) NSString*  favors;
@property (nonatomic, copy,readonly) NSString*  vieworder;
@property (nonatomic, copy,readonly) NSArray*   subforum;
@end

