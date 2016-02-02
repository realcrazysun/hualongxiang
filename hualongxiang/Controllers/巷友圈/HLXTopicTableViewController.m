//
//  HLXTopicTableViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/16.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HLXTopicTableViewController.h"
#import "HLXApi.h"
#import "UIColor+Wonderful.h"
#import "UIView+Util.h"
#import "HLXTopic.h"
#import "UIImageView+Util.h"
#import "HLXTopicCell.h"
@interface HLXTopicTableViewController ()

@end

@implementation HLXTopicTableViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        self.generateURL = ^(){
            return [NSString stringWithFormat:@"%@", HLXAPI_TOPICRANK];
        };
        self.objClass = [HLXTopic class];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    // Do any additional setup after loading the view.
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
         return self.objects.count;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
        label.text = @"本周话题排行";
        label.backgroundColor = [UIColor gainsboroColor];
        label.textColor = [UIColor darkTextColor];
        label.alpha = 0.5;
        return label;
    }
    return nil;
}
//- ( NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;{
//    return @"本周话题排行";
//}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* reuseIdentifier = @"reuseIdentifier";
    if (indexPath.section == 0) {
        UITableViewCell* cell =[ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        CGRect frame = cell.contentView.frame;
        
        //最新话题按钮
        UIButton* btnNew = [UIButton buttonWithType:UIButtonTypeCustom];
        btnNew.frame = CGRectMake(10, 5, frame.size.width/2 - 20, 50);
        btnNew.backgroundColor = [UIColor deepSkyBlue];
        btnNew.tag = 1;
        [btnNew addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btnNew setCornerRadius:5];
        [btnNew setTitle: @"最新话题" forState:UIControlStateNormal];
        [cell.contentView addSubview:btnNew];
        
        //我的话题按钮
        UIButton* btnMy = [UIButton buttonWithType:UIButtonTypeCustom];
        btnMy.frame = CGRectMake(CGRectGetMaxX(btnNew.frame)+10, 5, frame.size.width/2 - 20, 50);
        btnMy.backgroundColor = [UIColor darkCyan];
        btnMy.tag = 1;
        [btnMy addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btnMy setCornerRadius:5];
        [btnMy setTitle: @"我的话题" forState:UIControlStateNormal];
        [cell.contentView addSubview:btnMy];
        
        return cell;
    }
    
    HLXTopic* topic = self.objects[indexPath.row];
    
    HLXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[HLXTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }

    [cell setModel:topic];
    return cell;
}

-(void)clickBtn:(UIButton*)btn{
    NSLog(@"%d",btn.tag);
}

//去掉悬停
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
@end
