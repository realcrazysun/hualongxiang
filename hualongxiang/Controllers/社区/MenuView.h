//
//  MenuView.h
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSArray* data;
//@property(copy,nonatomic,readonly) id block;
@property (nonatomic, copy) void (^choose)(id content);
@property (nonatomic, copy) void (^dismissVC)();
-(instancetype)initWithFrame:(CGRect)frame WithData:(NSArray*)data  ;
@end
