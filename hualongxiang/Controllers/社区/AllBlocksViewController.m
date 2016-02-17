//
//  AllBlocksViewController.m
//  hualongxiang
//
//  Created by polyent on 16/1/24.
//  Copyright © 2016年 crazysun. All rights reserved.
//

#import "AllBlocksViewController.h"
#import "AFHTTPSessionManagerTool.h"
#import "HLXApi.h"
#import "ResponseRootObject.h"
#import "MenuView.h"
#import "Forum.h"
#import "UIColor+Wonderful.h"
@implementation AllBlocksViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"全部板块";
    title.textColor = [UIColor dimGray];
    self.navigationItem.titleView = title;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [AFHTTPSessionManagerTool sendHttpPost:HLXAPI_FORUM_FORUMS prefix:HLXAPI_PREFIX parameters:nil success:^(NSURLSessionDataTask * task, id responseObj) {
        ResponseRootObject* rootObj = [ResponseRootObject mj_objectWithKeyValues:responseObj];
        if ([rootObj.ret isEqualToString:@"0"]) {
            Forums* model = [Forums mj_objectWithKeyValues:rootObj.data];
            MenuView* view = [[MenuView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) WithData:model.forums];
            view.choose = _chooseBlock;
            __block typeof(self) blockself = self;
            view.dismissVC = ^{
                [blockself.navigationController dismissViewControllerAnimated:YES completion:nil];
            };
            [self.view addSubview:view];
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        //
    }];
}

- (void)cancelButtonClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
