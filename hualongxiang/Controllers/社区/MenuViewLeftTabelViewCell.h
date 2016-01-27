//
//  MenuViewLeftTabelViewCell.h
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define  LeftSelectColor        [UIColor blackColor]
#define  LeftSelectBgColor      [UIColor whiteColor]
#define  LeftBgColor            UIColorFromRGB(0xF3F4F6)
#define  LeftSeparatorColor     UIColorFromRGB(0xE5E5E5)
#define  LeftUnSelectBgColor    UIColorFromRGB(0xF3F4F6)
#define  LeftUnSelectColor      [UIColor blackColor]
@interface MenuViewLeftTabelViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setTitle:(NSString*)title;
-(void)clicked;
-(void)reset;
@end
