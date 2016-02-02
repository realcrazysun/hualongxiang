//
//  NearByViewController.h
//  hualongxiang
//
//  Created by polyent on 16/1/27.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHRadarView.h"
@interface NearByViewController : UIViewController<XHRadarViewDataSource, XHRadarViewDelegate>

@property (nonatomic, strong) XHRadarView *radarView;


@end
