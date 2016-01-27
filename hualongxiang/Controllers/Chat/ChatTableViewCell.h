//
//  ChatTableViewCell.h
//  hualongxiang
//
//  Created by polyent on 16/1/25.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
-(void)setData:(NSString*)imgUrl title:(NSString*)title subTitle:(NSString*)subTitle time:(NSString*)time;
@end
