//
//  DynamicInfoViewController.h
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//
#warning 该部分纯属自己瞎摸索。。。。仿照开源中国的写法 纯代码写感觉可扩展性强很多 应该封装成标签跟VC一一对应

#import <UIKit/UIKit.h>
#import "LabelSelectView.h"
@interface DynamicInfoViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet LabelSelectView *labelSelectView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

@end
