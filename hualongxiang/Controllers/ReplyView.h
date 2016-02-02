//
//  ReplyView.h
//  hualongxiang
//
//  Created by polyent on 16/1/29.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplyView : UIView
@property(nonatomic,copy)void (^clickContainer)();
-(instancetype)initWithFrame:(CGRect)frame liked:(BOOL)liked replyNums:(NSUInteger)replyNums;
-(void)setLiked:(BOOL)liked;
@end
