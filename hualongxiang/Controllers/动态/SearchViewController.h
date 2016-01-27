//
//  SearchViewController.h
//  hualongxiang
//
//  Created by polyent on 16/1/22.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SearchViewControllerState) {
    Idle,//默认从0开始
    Search,//展示搜索结果
};
@interface SearchViewController : UIViewController

@end
