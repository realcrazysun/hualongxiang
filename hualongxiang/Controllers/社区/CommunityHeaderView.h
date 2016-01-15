//
//  CommunityHeaderView.h
//  hualongxiang
//
//  Created by polyent on 16/1/14.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CommunityType) {
    CommunityTypeHot,//默认从0开始
    CommunityTypeFav,
};
@interface CommunityHeaderView : UIView
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UIView *indicatorView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
-(void)load:(NSArray*)arr;
-(void)initSubViews;
@end


@interface IconPage : UIView
-(instancetype)initWithFrame:(CGRect)frame andArr:(NSArray*)arr;
@end

@interface IconView : UIView
@property (strong, nonatomic)  UIImageView *imageView;
@property (strong, nonatomic)  UILabel *label;
@end
