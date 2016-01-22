//
//  NewPost.h
//  hualongxiang
//
//  Created by polyent on 16/1/18.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendObject.h"
@interface NewPostCell : UITableViewCell
@property (nonatomic, strong) NewPost *model;
@end

@interface UserIconContainerView : UIView
@property (nonatomic, strong) NSArray *iconArr;
@end

@interface CommentView : UIView
@property (strong, nonatomic) NSMutableArray *commentLabels;
+(CGFloat) getHeight:(NSArray*)array maxWidth:(CGFloat)maxWidth;
-(void) updateWithItem:(NSArray*)array;
@end