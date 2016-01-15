//
//  ChatRootViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/11.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "ChatRootViewController.h"

@implementation ChatRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView  setSeparatorColor:[UIColor  blackColor]];
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* reuseableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:reuseableIdentifier];
    }
    switch (indexPath.row)
    {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"10"];
            cell.textLabel.text = @"1234...";
            cell.detailTextLabel.text = @"123456789";
            break;
            
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"2"];
            cell.textLabel.text = @"1234...";
            cell.detailTextLabel.text = @"123456789";
            break;
            
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"3"];
            cell.textLabel.text = @"1234...";
            cell.detailTextLabel.text = @"123456789";
            break;
            
        default:
            cell.imageView.image = [UIImage imageNamed:@"5"];
            cell.textLabel.text = @"1234...";
            cell.detailTextLabel.text = @"123456789";
            break;
    }
    
    // Configure the cell...
    
    return cell;
}


@end
