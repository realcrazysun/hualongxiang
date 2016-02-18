//
//  CommunityHeaderView.h
//  hualongxiang
//  碰到scrollView 还是用纯代码写会比较好一点
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
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIButton *chooseBtn;

@property (strong, nonatomic)  UIPageControl *pageControl;
-(void)initData:(NSArray*)attention recommend:(NSArray*)recommend lastRefreshTime:(NSString*)lastRefreshTime;
@property (strong, nonatomic) NSArray* attention;
@property (strong, nonatomic) NSArray* recommend;
@end


@interface IconPage : UIView
@property(strong,nonatomic)NSArray* arr;
-(instancetype)initWithFrame:(CGRect)frame andArr:(NSArray*)arr;
@end

@interface IconView : UIView
@property (strong, nonatomic)  UIImageView *imageView;
@property (strong, nonatomic)  UILabel *label;
-(void)setData:(NSString*)imgUr title:(NSString*)title;
@end
