//
//  WEPopoverContentViewController.h
//  WEPopover
//
//  Created by Werner Altewischer on 06/11/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WEPopoverContentViewController : UITableViewController
@property(nonatomic,strong)void (^clickItem)(NSString* type);
- (instancetype)initWithStyle:(UITableViewStyle)style currentType:(NSUInteger)currentTypeIndex typeArray:(NSArray*)typeArray;
@end
