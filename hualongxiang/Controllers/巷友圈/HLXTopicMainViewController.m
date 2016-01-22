//
//  HLXTopicMainViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/16.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "HLXTopicMainViewController.h"
#import "UIColor+Wonderful.h"
@interface HLXTopicMainViewController ()

@end

@implementation HLXTopicMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat searchBarHeight = 45;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, searchBarHeight)];
    _searchBar.backgroundColor = [UIColor gainsboroColor];
    [self.view addSubview:_searchBar];
    
    _tableViewController = [[HLXTopicTableViewController alloc]init];
    _tableViewController.view.frame = CGRectMake(0, searchBarHeight, self.view.frame.size.width, self.view.frame.size.height - searchBarHeight);
    [self addChildViewController:_tableViewController];
    [self.view addSubview:_tableViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
