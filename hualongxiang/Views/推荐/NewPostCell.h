//
//  NewPost.h
//  hualongxiang
//
//  Created by polyent on 16/1/18.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendObject.h"
@protocol CommentViewDelegate <NSObject>
- (void)clickLabel:(long long)uid;
@end

@interface NewPostCell : UITableViewCell
@property (nonatomic, strong) NewPost *model;
-(void)setCommentViewDelegate:(id<CommentViewDelegate>) delegate;
@end

@interface UserIconContainerView : UIView
@property (nonatomic, strong) NSArray *iconArr;
+(CGFloat) getHeight:(NSArray *)iconArr;
@end




@interface CommentView : UIView

@property (strong, nonatomic) NSMutableArray *commentLabels;
@property (assign, nonatomic) id<CommentViewDelegate> delegate;
+(CGFloat) getHeight:(NSArray*)array maxWidth:(CGFloat)maxWidth;
-(void) updateWithItem:(NSArray*)array;
@end