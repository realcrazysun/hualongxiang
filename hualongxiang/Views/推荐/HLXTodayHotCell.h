//
//  HLXTodayHotCell.h
//  hualongxiang
//
//  Created by polyent on 16/1/17.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLXTodayHotCell : UITableViewCell
@property(nonatomic, strong) NSArray *arr;
//@property(nonatomic, assign) id<JZAlbumDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

-(void)setDataArr:(NSArray*) arr;
@end

@interface HLXTodayHotView:UIImageView
@property(nonatomic,strong)UIImageView* icon;
@property(nonatomic,strong)UILabel* label;
@end